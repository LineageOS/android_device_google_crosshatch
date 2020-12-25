/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.lineageos.settings;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.util.Log;

class EuiccDisabler {
    private static final String TAG = "GoogleParts";
    private static final String[] EUICC_DEPENDENCIES = new String[]{
        "com.google.android.gms",
        "com.google.android.gsf"
    };
    private static final String[] EUICC_PACKAGES = new String[]{
        "com.google.android.euicc",
        "com.google.euiccpixel",
        "com.google.android.ims"
    };

    private static boolean isInstalledAndEnabled(PackageManager pm, String pkgName) {
        try {
            PackageInfo info = pm.getPackageInfo(pkgName, 0);
            Log.d(TAG, "package " + pkgName + " installed, " +
                       "enabled = " + info.applicationInfo.enabled);
            return info.applicationInfo.enabled;
        } catch (PackageManager.NameNotFoundException e) {
            Log.d(TAG, "package " + pkgName + " is not installed");
            return false;
        }
    }

    private static boolean shouldDisable(PackageManager pm) {
        for (String dep : EUICC_DEPENDENCIES) {
            if (!isInstalledAndEnabled(pm, dep)) {
                // Disable if any of the dependencies are disabled
                return true;
            }
        }
        return false;
    }

    public static void enableOrDisableEuicc(Context context) {
        PackageManager pm = context.getPackageManager();
        boolean disable = shouldDisable(pm);
        int flag = disable
            ? PackageManager.COMPONENT_ENABLED_STATE_DISABLED
            : PackageManager.COMPONENT_ENABLED_STATE_ENABLED;
        for (String pkg : EUICC_PACKAGES) {
            pm.setApplicationEnabledSetting(pkg, flag, 0);
        }
    }
}
