Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424094AbWKPOS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424094AbWKPOS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424093AbWKPOS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:18:59 -0500
Received: from mail0.scram.de ([195.226.127.110]:27408 "EHLO mail0.scram.de")
	by vger.kernel.org with ESMTP id S1424064AbWKPOS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:18:58 -0500
Message-ID: <455C731A.4010503@scram.de>
Date: Thu, 16 Nov 2006 15:18:02 +0100
From: Jochen Friedrich <jochen@scram.de>
User-Agent: IceDove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       madwifi-devel@lists.sourceforge.net, lwn@lwn.net, mcgrof@gmail.com,
       david.kimdon@devicescape.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: ANNOUNCE: SFLC helps developers assess ar5k (enabling free Atheros
 HAL)
References: <20061115031025.GH3451@tuxdriver.com> <200611151942.14596.mb@bu3sch.de> <20061115192054.GA10009@tuxdriver.com> <200611152026.26095.mb@bu3sch.de>
In-Reply-To: <200611152026.26095.mb@bu3sch.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Spam-Report: Content analysis details: (0.0 points, 5.0 required)
	pts rule name description
	---- ---------------------- --------------------------------------------------
	0.0 AWL AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Michael,

>> I don't think anyone likes the HAL-based architecture.  I don't think
>> we will accept a HAL-based driver into the upstream kernel.
> 
> Yeah, wanted to hear that. ;)

+1

At least, this way we have a chance to get USB working as well (See http://madwifi.org/ticket/33).
OpenBSD seems to have a working driver (if_uath.c) for these USB WLAN sticks.

Jochen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQEVAwUBRVxzGsP9a9GOLSE6AQIeRgf/ZyvmzdhP1+wjVshy2kK0BX+I+lx7y6RO
mMmaVXPnXnHhHE4OLcf9Yrnn6d6i6rS+0CUbw60KgQouuvTFSXEFtSpIYRlXGAyj
krMCj8bEfHhDEN8iYjbjdhP9Nx1wQ//JGyoBVpZZ5+sro6ik7wv70igFeDZ2IWg6
38ycxDzINaV13ZscpwoHzO3NhvcSs9k99Syrh/nR6/pp+3g2vXmrsYR+hy7DMrE/
bSI9y50h8rz6ZCire1ppDwADyBW5B1OondoRkjFYd3L8zNUu8s8xUHZ0Znz6B/cc
yc7jyfQMsBRTUU7VsX3cWuMfA0UGlPn/0MR0+RHRJYHW5bRlStc5Kw==
=Ajsn
-----END PGP SIGNATURE-----
