Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288640AbSADOTm>; Fri, 4 Jan 2002 09:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288641AbSADOTc>; Fri, 4 Jan 2002 09:19:32 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:37977 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288640AbSADOTV>; Fri, 4 Jan 2002 09:19:21 -0500
Date: Fri, 4 Jan 2002 14:18:36 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wakko Warner <wakko@animx.eu.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 with es1370 pci
Message-ID: <20020104141836.A31331@grobbebol.xs4all.nl>
In-Reply-To: <20020101104611.A30843@animx.eu.org> <E16LSVd-0000pj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16LSVd-0000pj-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
X-OS: Linux grobbebol 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 05:15:28PM +0000, Alan Cox wrote:
> Boot withg the "noapic" option. Quite how your system has managed to
> lose an interrupt in the APIC hardware I don't know, but the APIC's
> certainly have bugs. It could also be an edge/level trigger but if the BIOS
> confused it because IRQ15 was for some kind of IDE device, but I see no
> evidence of that.

I also have had a lot of problems with /dev/dsp in a SMP setup and with
noapic, all at least lives for weeks without problems.

this was with a SB16, if that matters, with opensound.

-- 
Grobbebol's Home                        |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel            | Use your real e-mail address   /\
Linux 2.4.17 (noapic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
