Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTEaSP1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTEaSP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:15:27 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:11392
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264397AbTEaSP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:15:26 -0400
Date: Sat, 31 May 2003 14:18:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Paul Rolland <rol@as2917.net>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.70] - APIC error on CPU0: 00(40)
In-Reply-To: <00ae01c3279e$e7bb3e70$2101a8c0@witbe>
Message-ID: <Pine.LNX.4.50.0305311418030.32537-100000@montezuma.mastecende.com>
References: <00ae01c3279e$e7bb3e70$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Paul Rolland wrote:

> Hello,
> 
> > On Sad, 2003-05-31 at 11:52, mikpe@csd.uu.se wrote:
> > > Received illegal vector errors. Your boot log reveals that you're 
> > > using ACPI and IO-APIC on a SiS chipset. Disable those and 
> > try again 
> > > -- I wouldn't bet on ACPI+IO-APIC working on SiS.
> > 
> > 2.5.x has the needed code to handle SiS APIC. Does Linus 
> > 2.5.70 also have the fixes to not re-route the SMI pins ?
> 
> Where should this code be located ?
> 
> I'm ready to check my source tree, and compare with 2.5.69,
> and try to make a patch ...

It's already in 2.5.70

	Zwane
-- 
function.linuxpower.ca
