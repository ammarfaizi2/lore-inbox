Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTE0Ma0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTE0MaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:30:25 -0400
Received: from cae168-250-170.sc.rr.com ([24.168.250.170]:63167 "EHLO jaos.org")
	by vger.kernel.org with ESMTP id S263451AbTE0MaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:30:21 -0400
From: Jason Woodward <woodwardj@jaos.org>
To: davej@codemonkey.org.uk
Content-Type: multipart/mixed; boundary="boundary-1054039885"
Message-Id: <mailbox-6849-1054039886@jaos.org>
Date: Tue, 27 May 2003 08:51:26 -0400
MIME-Version: 1.0
cc: adaplas@pol.net, linux-kernel@vger.kernel.org
subject: Re[2]: [patch] 2.5.70: drivers/video/i810/i810.h
X-Mailer: PerlWebmail version 3 (http://software.jaos.org)
References: 20030527124251.GA28799@suse.de
In-Reply-To: 20030527124251.GA28799@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--boundary-1054039885
Content-Type: text/plain; charset="us-ascii"
Content-Length: 1985
Lines: 46

Apologies,  I just noticed the post from Herbert Xu.

take care,
jason

On Tue May 27 12:42:51 2003, Dave Jones wrote:
> On Tue, May 27, 2003 at 08:43:08AM -0400, Jason Woodward wrote:
>  > Here is a patch against 2.5.70 that fixes a compilation error for i810:
> 
> Already fixed in the agpgart bk tree. The pull request to Linus
> got sent just a few minutes too late for 2.5.70.
> There's also a fix there for the sis driver that has the same problem.
> 
> 		Dave


--
Jason Woodward
woodwardj@jaos.org

Key fingerprint = 8808 4E3B D4F2 0B84 AAB0  E1A6 6BB6 DA87 54A7 FA1E
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

mQGiBDrwHPoRBAC3nDJRLKTcFcJWid9PN08ChMI7tuQevomWoVeZpZZ0zzip2w/E
ts55Mx58eRRGFFmgZZGeP7EhyUPzb668LIsU62gFO7G5/oWCr3U3g3peabZsqRC9
FchdiM8DJqQu/7ryAjbQ4OFCSW+jAsMC3tKXrdaB48WiipiXUcKR/sONGwCgzGPf
yxDgOc7n9xWVH0qbUDC/vZsEAKvbckkhpe9/x2A4E15l6DUbliEmboeHiT9NJaok
vLo3ElSO1o6ld5+VhFIkhRmmovrS8oyttZNv8HjMEYf6L3NdZybTHfcdS5EIpguH
Xx2/IGzJKbgX3vM/qhJ0+F1LPuN20mOT0NO/29AXJn3V7rTKoKf/uOOKD+Eqh4r1
QVMoBAC3ZPF3idmuW3j4tqhOaWe2qHlLwEClwdsTG+KOsVYh1sU4RvyMErDIU6r/
MomkLAJfbtBTXKcknW68Y4Uv4B+UkyopklktRBFiMBffoHLUfkkQk/L9Yg1YG27N
COsECiamylF8hNSTcNIQqYXDpyoRcSi2p7gqkxJZrk7GwrX2ObQjSmFzb24gV29v
ZHdhcmQgPHdvb2R3YXJkakBqYW9zLm9yZz6IVwQTEQIAFwUCOvAc+gULBwoDBAMV
AwIDFgIBAheAAAoJEGu22odUp/oeN2IAoKHS+qH8AenlOTKL0Ifl3q1QSlDBAKDL
bvvgl7HoRTHY2b9n3pEPr+KIh7kBDQQ68Bz9EAQA2Ds/2VKc08qaNIkA1okxITmQ
aaNjUrm/au9jNzm9lyEFXWXBNegzP5Y4A1ESDKUt5RETgVhNKd9mGkP7tgPTs3f6
Z595K6W7xeZWONKbl578RbWwE1CiMqEOuXwr1/q0DzfwmNQLcqDcX3o0DEpWE+uZ
G+5CtpkXYiDmccigDKMAAwUD/iZDxEr1HC4iLnGXUCDpxXEtp7Fx150baFzZITns
4hpKRAbTR65s2tL8rh5d8ThDgqW5C9JQja9fMxI2u7zlyM2ALFXJP1xwgZTSOYvn
sq+x41i5tJpce+pDmMEl8X0wew2Z5ZRPfDLv64kKPIGNgVXsAHirH2KjChZat4VC
qkZciEYEGBECAAYFAjrwHP0ACgkQa7bah1Sn+h7qkQCePz0ds5O/dsZrm450pjLs
2V3BkMAAn2/6alBBC9b9F94svdOf0mGY/G5w
=4p8c
-----END PGP PUBLIC KEY BLOCK-----

--boundary-1054039885--
