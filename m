Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312830AbSCZXZu>; Tue, 26 Mar 2002 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312827AbSCZXZk>; Tue, 26 Mar 2002 18:25:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49674 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312826AbSCZXZf>; Tue, 26 Mar 2002 18:25:35 -0500
Subject: Re: 2.4.19-pre4-ac1 vmware and emu10k1 problems
To: magamo@ranka.2y.net (Malcolm Mallardi)
Date: Tue, 26 Mar 2002 23:41:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020326160638.A2103@trianna.upcommand.net> from "Malcolm Mallardi" at Mar 26, 2002 04:06:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16q0ZJ-0004D0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The vmware modules will not compile properly under 2.4.19-pre4-ac1, or
> under 2.4.19-pre2-ac2, but compile fine on their mainline kernel
> counterparts.  Here is the errors that I get from vmware-config.pl:

Please take vmware problems up with the vmware folks

> Also, under 2.4.19-pre4-ac1, when the emu10k1 module is loaded, I get a
> large amount of constant static until I rmmod it.  2.4.19-pre4's
> initialization of the emu10k1 driver is fine, and when the emu10k1
> driver is replaced with the latest CVS version of the emu10k1 driver,
> it initializes and performs normally.

I'll take a look at that see whats up
