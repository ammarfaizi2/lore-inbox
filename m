Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTFLMGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTFLMGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:06:47 -0400
Received: from smtp02.web.de ([217.72.192.151]:41226 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264374AbTFLMGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:06:46 -0400
Message-ID: <000f01c33013$c713eeb0$6602a8c0@Schleppi>
From: "Gregor Essers" <gregor.essers@web.de>
To: "I Am Falling I Am Fading" <skuld@anime.net>
Cc: <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306120512320.13378-100000@inconnu.isu.edu>
Subject: Re: Via KT400 and AGP 8x Support
Date: Wed, 11 Jun 2003 14:19:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi i will look into that with the bridges, i hope that Hercules is so that
they give me the spec´s (Plan of the Card) with the Jupers/Bridges for AGP
2.0.

The minus on Performace is not great, in my eyes.

It´s very SAD that Ati and Nvidia will not give the Specs or an Sourcecode
of the Drivers :/.

Regards

Gregor Essers

----- Original Message -----
From: "I Am Falling I Am Fading" <skuld@anime.net>
To: "John Bradford" <john@grabjohn.com>
Cc: <davej@codemonkey.org.uk>; <gregor.essers@web.de>;
<linux-kernel@vger.kernel.org>
Sent: Thursday, June 12, 2003 1:15 PM
Subject: Re: Via KT400 and AGP 8x Support


> On Thu, 12 Jun 2003, John Bradford wrote:
>
> > > The only other solution is to kick your card down into AGP 2.0 mode,
which
> > > most BIOSes do not allow you to do in software. Instead what you have
to
> > > do is cut/unsolder traces on your video card for the pins used for AGP
3.0
> > > detection. This is a near-permanent and horrible solution but it does
get
> > > everything working. :-/
> >
> > Insulating tape on certain pins works on ISA cards, but whether it would
be
> > practical on the smaller pins of an AGP card, I'm not sure.
>
> Tried it already... The pins are too small to get adequate purchase for
> the tape -- the friction just causes it to slide around in the slot and
> gets goo around.
>
> Superglue might be a better solution....
>
> ...but I think the solder method is better.
>
> On the Radeon 9700 Pro at least there are a couple jumpers on the
> appropriate pins, bridged by 0-ohm surface mount resistors (i.e. simple
> conductors). What you can do is just unsolder the bridges and it becomes
> an AGP 2.0 card... If you have a very steady hand you can also resolder
> them to get your AGP 3.0 back.
>
> Still this is not a fun solution as you can potentially cook your card
> (make sure to use a 15 watt iron, nothing higher).
>
> -----
> James Sellman -- ISU CoE-CS/ISLUG Linux Lab Admin   |"Lum, did you just
see
> ----------------------------------------------------| a hentai rabbit
flying
> skuld@inconnu.isu.edu      |   // A4000/604e/60 128M| through the air?"
> skuld@anime.net            | \X/  A500/20 3M        |   - Miyake Shinobu
>
>

