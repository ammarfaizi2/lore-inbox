Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131813AbQLJSwi>; Sun, 10 Dec 2000 13:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131641AbQLJSw2>; Sun, 10 Dec 2000 13:52:28 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:30088 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131813AbQLJSwO>; Sun, 10 Dec 2000 13:52:14 -0500
Message-ID: <3A33C9AD.AC2D741D@haque.net>
Date: Sun, 10 Dec 2000 13:21:33 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: philippe <philippe.amelant@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Enviromental Monitoring
In-Reply-To: <002901c062c9$f183d030$fdfea8c0@localnet> <20001210110213.X6567@cadcamlab.org>  <m2aea42ock.fsf@barnowl.demon.co.uk> <20001210171631.988B828164@postfix1.free.fr>
Content-Type: multipart/mixed;
 boundary="------------E7A21E403A23F77CA5D9D373"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E7A21E403A23F77CA5D9D373
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Try this patch against the 2.5.x series. I submitted it to them back
when it broke with test8 but never checked if it made it in.



philippe wrote:
> 
> lm_sensors 2.4.5 work fine for my abit bp6
> cannot succed to use 2.5.x serie

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------E7A21E403A23F77CA5D9D373
Content-Type: application/x-gzip;
 name="lm_sensors-2.5.2+2.4.0-test8-pre2.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lm_sensors-2.5.2+2.4.0-test8-pre2.diff.gz"

H4sICIeisTkAA2xtX3NlbnNvcnMtMi41LjIrMi40LjAtdGVzdDgtcHJlMi5kaWZmAJ1V32/a
MBB+hr/i+rCOEAdIKJTRUtFNdJpUtRO02sukKASnRDVJ5jiruqn/++zYAfKrpctD4tx9d777
7uxb+Z4HRkKfgGzsGAdxSGPD6gw6VvcR0wCTrhJ23BLC2KydXwkuAZuGYbztrnGXYLiMKJgj
6J2OLXPcG4LV6/Wauq4fvFdj4TBY4AjA4sbjwXBsWtLLdAqG9amPTkEXnxFMp01o8Af44xIf
B8xmS2JcRDR0A2eDtbNU73vQWiYewQHo4CaUr2P/D4YLaHNZpEknCjGRQjD2kGdNgwPcMHq2
WWgnMaY2xUz49DBF8Pn+CoE0R8bs6vL++o7vrKc7t/atqiw0LUU2uMOEBqDsZeB7seoThZea
lrt2KLQ1kB4L6peUqr5lIXMIet/qI/M0T9baJyvpqbFymNOJn2OXEdtf8fz3mRRCwaTCxoy6
0XMrNRFiVEe74KtMWEhWvx2C4Fg4QDLvIkUFTLptGjMIHkKvxWNIXCZ3kBrVOjbPKoptYach
qYeKJ1+hehdZYSorsyuAjJcXYMduLtAq18pHQDGJdV3+vYg3dyZ7MFVB+xBXPNEoYTmSRSOC
/Eb5juRsZ+AiUOVbzlZEpqT8wyWyvU6sITIHoJ9YI2RmZ1EctULsJAweNDhX28jDVpdnij3L
MaHChG4Oo5VsjFf6jeI4ISzOUt2j5L3kVbZqwX0Nkf/PPn+nvOIn0WnHx8BXYh/4K5jqtuEm
ZBjYGgMNk2DlBw/gOS4L6RG0uwIi8WBMlCV8KBMuK7FFdGvo9Wi42dG1zVzGhpR1NW1b0zqz
Og5Ull8xS5PkYOBWCY5h6biPwMJULG8ilbHrECKULSlFsJjdLG7nC/v7/PaLPZ9dXts/5t/u
ZgiYsyR4d9GhtLcHpwMxZQaj3nbKbJwHzg5/Bz5LVliFJfsdjibQE+UQl06unz7CRwSFy7o8
I7ZNUQU/bEBk10iraK0U8swOzQEyT0AfWqYYDTKztIGeQNQIfJbRKeIx4shxcTZjJLOvDFO1
lEd8N04zRGmivn+gHj5PK9iqnaavDVN5NCSJL+og7jk632Uty5+v/s/grfLnql8FPySfXXhb
sic5sv8BnDRbUxQKAAA=
--------------E7A21E403A23F77CA5D9D373--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
