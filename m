Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265583AbSJSKIm>; Sat, 19 Oct 2002 06:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSJSKIl>; Sat, 19 Oct 2002 06:08:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:782 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265583AbSJSKIk>; Sat, 19 Oct 2002 06:08:40 -0400
Message-Id: <200210191009.g9JA9Dp15342@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.4.19 orinoco_cs with Lucent WaveLAN "bronze"
Date: Sat, 19 Oct 2002 15:02:06 +0000
X-Mailer: KMail [version 1.3.2]
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org
References: <200210190922.g9J9M4p15225@Port.imtp.ilyichevsk.odessa.ua> <20021019105938.A14830@flint.arm.linux.org.uk>
In-Reply-To: <20021019105938.A14830@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 October 2002 09:59, Russell King wrote:
> On Sat, Oct 19, 2002 at 02:14:57PM +0000, Denis Vlasenko wrote:
> > Today I played with wireless LAN euqipment for the first time.
> > I have ISA-to-PCMCIA converter and a Lucent (IEEE) PCMCIA card.
> > I set up everything as directed by HOWTOs. I do:
>
> Yes, I also noticed many problems with the current orinoco_cs driver.
> I've reported them to David, but had very little response thus far.

I have stanalone drivers from pcmcia-cs-3.2.1 too but wanted to
concentrate on testing in-kernel ones.

Well, 2.4 kernel sources say development will proceed on orinoco_cs,
not {wave|wv}lan_cs. Jean, can you clear the confusion? I'm afraid
I can do testing only today and tomorrow... have to return the card
by Monday.
--
vda
