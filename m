Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285915AbRLYVxM>; Tue, 25 Dec 2001 16:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285927AbRLYVxC>; Tue, 25 Dec 2001 16:53:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285915AbRLYVwt>; Tue, 25 Dec 2001 16:52:49 -0500
Subject: Re: RTNETLINK
To: jjs@pobox.com (J Sloan)
Date: Tue, 25 Dec 2001 22:02:51 +0000 (GMT)
Cc: garzik@havoc.gtf.org (Legacy Fishtank),
        manfred@colorfullife.com (Manfred Spraul),
        klink@clouddancer.com (Colonel), linux-kernel@vger.kernel.org
In-Reply-To: <3C28D260.65548D33@pobox.com> from "J Sloan" at Dec 25, 2001 11:24:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Izet-0008Be-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Legacy Fishtank wrote:
> 
> > It's required by newer RedHat and MDK initscripts, perhaps others.
> > ip, iproute and similar utilities use it, and so since it's commonly
> > required DaveM made it unconditional...  I think the checkin comment was
> > something along the lines of "make it unconditional unless Alan
> > complains about kernel bloat" :)
> 
> Hmm, perhaps RTNETLINK should be enabled
> IFF networking is selected? I see to remember
> that was the idea being bandied about...
> 
> Anyway, Merry Christmas to all -
> 
> jjs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

