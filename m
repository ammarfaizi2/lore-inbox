Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbTFCPfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbTFCPfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:35:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265052AbTFCPe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:34:56 -0400
Date: Tue, 3 Jun 2003 08:47:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: venom@sns.it
Cc: andreas@xss.co.at, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: system clock speed too high?
Message-Id: <20030603084737.33a5f817.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.43.0306031742530.24604-100000@cibs9.sns.it>
References: <3EDCC0E1.90503@xss.co.at>
	<Pine.LNX.4.43.0306031742530.24604-100000@cibs9.sns.it>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Did you check to see if USB is enabled in your BIOS setup?
Nothing to do with Linux USB kernel support....

~Randy

On Tue, 3 Jun 2003 17:43:42 +0200 (CEST) venom@sns.it wrote:

| 
| No, I do not have USB enabled at all.
| anyway I see exactly the same results, also if the problem could be somewhere
| else.
| 
| Luigi
| 
| On Tue, 3 Jun 2003, Andreas Haumer wrote:
| 
| > Date: Tue, 03 Jun 2003 17:38:09 +0200
| > From: Andreas Haumer <andreas@xss.co.at>
| > To: venom@sns.it
| > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
| >      Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
| > Subject: Re: system clock speed too high?
| >
| > -----BEGIN PGP SIGNED MESSAGE-----
| > Hash: SHA1
| >
| > Hi!
| >
| > venom@sns.it wrote:
| > > I reported this same problem for kernel 2.5.69/70 on pentiumIII with chipset
| > > i810, but it seems the reports has been unnoticed.
| > >
| > > I replicated your tests with 2.5.70 without acpi, same results here.
| > >
| > Hm, do you have "USB legacy support" enabled on your
| > system, too? Does the problem go away if you disable it?
| >
| > What motherboard and BIOS does your computer have (manufacturer,
| > version numbers)?
| >
| > (This is a totally different chipset, so the problems
| > might be completely unrelated)
| >
| > - - andreas
| >
| > - --
| > Andreas Haumer                     | mailto:andreas@xss.co.at
| > *x Software + Systeme              | http://www.xss.co.at/
| > Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
| > A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
