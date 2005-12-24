Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVLXRcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVLXRcf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 12:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVLXRcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 12:32:35 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:20154 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751247AbVLXRce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 12:32:34 -0500
Message-ID: <43AD8631.1090605@comcast.net>
Date: Sat, 24 Dec 2005 12:32:33 -0500
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Machine check 2.6.13.3 dual opteron
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi everybody,

My machine locked up on me and I found this message on my serial
console.  I have no idea how to decode its meaning - can you help?

CPU 0: Machine Check Exception:                4
Bank 4: b200000000070f0f
TSC 39619ee1e2187
Kernel panic - not syncing: Machine check

My machine is a dual Opteron running the 2.6.13.3 kernel.  I'm not
positive, but I think I can reproduce it.  Assuming that I can, what
information would be helpful to debug the problem?

Please cc: me on the response as I am not subscribed to this mailing list.

Thanks!

Andy
- --
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDrYYxHl0iXDssISsRAjONAJ9zoU0vSmikAkMqmQI2po0Jp9E83QCghO/M
Zxq/FKaldR1hzyrJqiJ+sMg=
=gdcL
-----END PGP SIGNATURE-----
