Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVBGQkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVBGQkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVBGQkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:40:11 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:34454 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261188AbVBGQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:40:00 -0500
Subject: Re: [RFC] Reliable video POSTing on resume
From: Li-Ta Lo <ollie@lanl.gov>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Adam Sulmicki <adam@cfar.umd.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42077AC4.5030103@grupopie.com>
References: <e796392205020221387d4d8562@mail.gmail.com>
	 <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
	 <9e473391050204093837bc50d3@mail.gmail.com>
	 <20050205093550.GC1158@elf.ucw.cz>
	 <1107695583.14847.167.camel@localhost.localdomain>
	 <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu>
	 <42077AC4.5030103@grupopie.com>
Content-Type: text/plain
Organization: Los Alamos National Lab
Message-Id: <1107794388.2930.38.camel@logarithm.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Feb 2005 09:39:48 -0700
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 07:27, Paulo Marques wrote:
> I still don't have hard numbers from the work Li-Ta Lo is doing (I'm 
> CC'ing him on this thread to see if he can shed some light here), but I 
> guess that you could have the complete emulator for about 50kB of code.

The difference between the "uncompressed" romimage is 41376 bytes for
Tyan S2885 mainboard. The difference of compressed romimage is 16943 
bytes.

Ollie


