Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbTFCPaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbTFCPaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:30:18 -0400
Received: from cibs9.sns.it ([192.167.206.29]:61190 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S265054AbTFCPaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:30:16 -0400
Date: Tue, 3 Jun 2003 17:43:42 +0200 (CEST)
From: venom@sns.it
To: Andreas Haumer <andreas@xss.co.at>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system clock speed too high?
In-Reply-To: <3EDCC0E1.90503@xss.co.at>
Message-ID: <Pine.LNX.4.43.0306031742530.24604-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No, I do not have USB enabled at all.
anyway I see exactly the same results, also if the problem could be somewhere
else.

Luigi

On Tue, 3 Jun 2003, Andreas Haumer wrote:

> Date: Tue, 03 Jun 2003 17:38:09 +0200
> From: Andreas Haumer <andreas@xss.co.at>
> To: venom@sns.it
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
>      Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: system clock speed too high?
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi!
>
> venom@sns.it wrote:
> > I reported this same problem for kernel 2.5.69/70 on pentiumIII with chipset
> > i810, but it seems the reports has been unnoticed.
> >
> > I replicated your tests with 2.5.70 without acpi, same results here.
> >
> Hm, do you have "USB legacy support" enabled on your
> system, too? Does the problem go away if you disable it?
>
> What motherboard and BIOS does your computer have (manufacturer,
> version numbers)?
>
> (This is a totally different chipset, so the problems
> might be completely unrelated)
>
> - - andreas
>
> - --
> Andreas Haumer                     | mailto:andreas@xss.co.at
> *x Software + Systeme              | http://www.xss.co.at/
> Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
> A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQE+3MDWxJmyeGcXPhERAmk+AKDER5RkBffYSYFpnNFq7nKhaqPwyACgr1rJ
> UxspwdElGOOGQs58Ol1N5v4=
> =Gb0Z
> -----END PGP SIGNATURE-----
>

