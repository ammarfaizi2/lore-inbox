Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262751AbTCPUuw>; Sun, 16 Mar 2003 15:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262753AbTCPUuw>; Sun, 16 Mar 2003 15:50:52 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:22184 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S262751AbTCPUuv>; Sun, 16 Mar 2003 15:50:51 -0500
Date: Sun, 16 Mar 2003 22:01:44 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, andi@lisas.de
Subject: Re: [Bug 464] New: 2.5.64: Dell Inspiron 8000 BIOS A04 EMERGENCY SHUTDOWN!
Message-ID: <20030316210144.GA13472@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
References: <57820000.1047827557@[10.10.2.4]> <20030316203629.GA13006@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316203629.GA13006@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 16, 2003 at 09:36:29PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Steps to reproduce:
> > I don't want to describe that here, since I really don't intend to put my
> > machine through yet another emergency shutdown...
> > You need to produce some high CPU load, though...
> 
> Heh, show us /proc/acpi/thermal/*.
Heh, gotcha!
It was in the attachments of bug #464 already... ;-)
(it's /proc/acpi/thermal_zone/*, BTW)

And don't expect any spectacular values just before shutdown there...
The thermal management is almost non-existent according to these values.

> Also don't fear emergency shutdowns -- they do NOT damage
> hardware. [This machine survived >20 of them.]
Yeah, and your 21st shutdown will kill it, for sure ;-)

Thanks for your reply!

Andreas Mohr

-- 
Help prevent Information Technology Fascism! - before it's too late...
http://www.againsttcpa.com
