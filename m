Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSLSPlt>; Thu, 19 Dec 2002 10:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSLSPlt>; Thu, 19 Dec 2002 10:41:49 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:3039
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265637AbSLSPls>; Thu, 19 Dec 2002 10:41:48 -0500
Date: Thu, 19 Dec 2002 10:52:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: parport_serial link order bug, NetMos support
In-Reply-To: <E18OxWK-0004w8-00@alf.amelek.gda.pl>
Message-ID: <Pine.LNX.4.50.0212191049020.2159-100000@montezuma.mastecende.com>
References: <E18OxWK-0004w8-00@alf.amelek.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Marek Michalkiewicz wrote:

> Hello,
>
> I've been trying (for quite a long time now, starting around the
> time when 2.4.19 was released) to submit the following patches into
> the 2.4.x kernel:
>
> http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/00_parport_serial
> http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/01_netmos
>
> (generated for 2.4.20-pre9, but apply cleanly to 2.4.20-final too,
> 00_parport_serial needs to be applied before 01_netmos).

I have local patches which do the same and have been using them for about
a year too (also at 115k). Regarding the parallel port aspect of the card,
i have tested using shared IRQs by running an epat cdrom via said port and
generating a high amount of serial i/o

00:10.0 Communication controller: NetMos Technology 222N-2 I/O Card (2S+1P) (rev 01)

Last time i posted regarding this, Tim Waugh says that the cards brought
about a number of issues, of which i am unable to recollect.

	Zwane
-- 
function.linuxpower.ca
