Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbTFCPYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbTFCPYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:24:46 -0400
Received: from camus.xss.co.at ([194.152.162.19]:39693 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S265047AbTFCPYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:24:45 -0400
Message-ID: <3EDCC0E1.90503@xss.co.at>
Date: Tue, 03 Jun 2003 17:38:09 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: venom@sns.it
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system clock speed too high?
References: <Pine.LNX.4.43.0306031714570.24363-100000@cibs9.sns.it>
In-Reply-To: <Pine.LNX.4.43.0306031714570.24363-100000@cibs9.sns.it>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

venom@sns.it wrote:
> I reported this same problem for kernel 2.5.69/70 on pentiumIII with chipset
> i810, but it seems the reports has been unnoticed.
>
> I replicated your tests with 2.5.70 without acpi, same results here.
>
Hm, do you have "USB legacy support" enabled on your
system, too? Does the problem go away if you disable it?

What motherboard and BIOS does your computer have (manufacturer,
version numbers)?

(This is a totally different chipset, so the problems
might be completely unrelated)

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+3MDWxJmyeGcXPhERAmk+AKDER5RkBffYSYFpnNFq7nKhaqPwyACgr1rJ
UxspwdElGOOGQs58Ol1N5v4=
=Gb0Z
-----END PGP SIGNATURE-----

