Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWETNHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWETNHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 09:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWETNHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 09:07:53 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:47801 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964835AbWETNHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 09:07:53 -0400
Message-ID: <446F138F.4020801@comcast.net>
Date: Sat, 20 May 2006 09:03:11 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IA-32 on x86-64
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Does anyone know how to check if I'm running an IA-32 process on x86-64?
 More importantly, how do I tell how big the user VM space is for
current?  Like 3GiB for x86 and who knows what (87GiB?  192GiB?) for
x86-64 and however much for sparc/ppc ....

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRG8Tjgs1xW0HCTEFAQLGPw/+MnsPqRchMPTfPAnmElB1I0drQpGKSzXM
fbalToXhv1EKWnPN/Sj8JdVenech3okH75W6/Y+OGMOjTWYw46uvhVr9KBcXWxRU
3+Fkx6iJPTIklhOWkbxZKnDirFttZnAh0oU0akRv8ko8Y25siohRU5WU/ALulq1l
ntlgHRz0mFhrVNukBEklq7nPre5/xJHLuwvDh2DKeMSbPHH5AsMC5li2Aa8tU72E
C83cwrRfGF5rUvlz7ILU/CeWfLU2TyVH/ow/zUzs9Snbndpo9KCekm+MwdUGj3YP
zt+bSMyKafBzpkrKrG11hm8l4j2Sxw9LdOCtD9Vbfu1e6YORnh/KHx6NNQ9+HibH
7UHZjlYwMq8I9VvJEWGcU43IsDp5q0VQ0W2vcEvdVcPmhmB2cRVljOdxXTQCAN86
ET2v6glufIvKy38ThO81zhgoxdnpGvJP4Tec34zihaNGDQ/jkzA23O8/8SLwFHr6
TizaQQsQLCAGOTRhGK4Phl2Yp+VJeKO9mq0vjAb9OBMl05MgLlqcJGm+MdLC1n+m
FxHs568tPp07EnjX1UlADXVUa8dAHbjFPAyupW/M/HIe1uv5fbwB9kn0MAlVqm2u
7AkMfiFhgv6Bvoylb2b17iWDbsLBo0N77++9r1Wn5bRkU99rfCTwmI1fBrH57Q5N
N2qNcoKBXpY=
=Nzyw
-----END PGP SIGNATURE-----
