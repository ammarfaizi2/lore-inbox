Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129437AbQLDPKY>; Mon, 4 Dec 2000 10:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbQLDPKO>; Mon, 4 Dec 2000 10:10:14 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:65468 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129437AbQLDPKH>; Mon, 4 Dec 2000 10:10:07 -0500
Date: Mon, 4 Dec 2000 09:39:32 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: "Garst R. Reese" <reese@isn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre4 drivers/net/dummy
In-Reply-To: <Pine.LNX.3.96.1001204020417.19309C-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0012040937470.14256-200000@viper.haque.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1104939946-975940772=:14256"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1104939946-975940772=:14256
Content-Type: TEXT/PLAIN; charset=US-ASCII

Ok, so here's the proper patch for those who dont want to wait for t5 =)
Ignore previous.

On Mon, 4 Dec 2000, Jeff Garzik wrote:

> the fix is in module.h which needs extra parens in the def of
> set_module_owner...
>
> 	Jeff

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

---1463811839-1104939946-975940772=:14256
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="module.h-t12p4.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0012040939320.14256@viper.haque.net>
Content-Description: 
Content-Disposition: attachment; filename="module.h-t12p4.diff"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvbW9kdWxlLmgub3JpZwlNb24gRGVj
ICA0IDA5OjE1OjM4IDIwMDANCisrKyBsaW51eC9pbmNsdWRlL2xpbnV4L21v
ZHVsZS5oCU1vbiBEZWMgIDQgMDk6MzU6MjUgMjAwMA0KQEAgLTM0NSw3ICsz
NDUsNyBAQA0KICNlbmRpZiAvKiBNT0RVTEUgKi8NCiANCiAjaWZkZWYgQ09O
RklHX01PRFVMRVMNCi0jZGVmaW5lIFNFVF9NT0RVTEVfT1dORVIoc29tZV9z
dHJ1Y3QpIGRvIHsgc29tZV9zdHJ1Y3QtPm93bmVyID0gVEhJU19NT0RVTEU7
IH0gd2hpbGUgKDApDQorI2RlZmluZSBTRVRfTU9EVUxFX09XTkVSKHNvbWVf
c3RydWN0KSBkbyB7IChzb21lX3N0cnVjdCktPm93bmVyID0gVEhJU19NT0RV
TEU7IH0gd2hpbGUgKDApDQogI2Vsc2UNCiAjZGVmaW5lIFNFVF9NT0RVTEVf
T1dORVIoc29tZV9zdHJ1Y3QpIGRvIHsgfSB3aGlsZSAoMCkNCiAjZW5kaWYN
Cg==
---1463811839-1104939946-975940772=:14256--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
