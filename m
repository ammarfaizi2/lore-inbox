Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281852AbRLHPec>; Sat, 8 Dec 2001 10:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRLHPeM>; Sat, 8 Dec 2001 10:34:12 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:60802 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S281852AbRLHPeC>;
	Sat, 8 Dec 2001 10:34:02 -0500
Message-Id: <m16CjTx-000OWoC@amadeus.home.nl>
Date: Sat, 8 Dec 2001 15:33:41 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: pproios@hotmail.com (Pantelis Proios)
Subject: Re: Memory Interleave + kernel + VIA chipsets == possible ?
cc: linux-kernel@vger.kernel.org
In-Reply-To: <F760JPzw2O8Z9B5un770001e64e@hotmail.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <F760JPzw2O8Z9B5un770001e64e@hotmail.com> you wrote:

> Is there a way to enable the memory interleaving of modern VIA chipsets 
> (Apollo Pro-133 in my case) through the Linux kernel or some other software?

>>From what I understand it's done through some PCI register tweaking ..
> Can it be done with setpci or code is needed ?

> any info would be welcomed

Search sourceforge for "powertweak"
