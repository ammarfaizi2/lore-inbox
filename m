Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284242AbRLPE5F>; Sat, 15 Dec 2001 23:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284243AbRLPE4y>; Sat, 15 Dec 2001 23:56:54 -0500
Received: from dsl-213-023-043-217.arcor-ip.net ([213.23.43.217]:23045 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284242AbRLPE4n>;
	Sat, 15 Dec 2001 23:56:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc1
Date: Sun, 16 Dec 2001 05:59:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ken Brownfield <brownfld@irridia.com>
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0112131841080.28446-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16FTOd-00007M-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 13, 2001 09:44 pm, Marcelo Tosatti wrote:
> rc1: 
> 
> - Finish MODULE_LICENSE fixups for fs/nls 	(Mark Hymers)
> - Console race fix				(Andrew Morton/Robert Love)
> - Configure.help update				(Eric S. Raymond)
> - Correctly fix Direct IO bug			(Linus Benedict Torvalds)
> - Turn off aacraid debugging			(Alan Cox)
> - Added missing spinlocking in do_loopback()	(Alexander Viro)
> - Added missing __devexit_p() in i82092 
>   pcmcia driver					(Keith Owens)
> - ns83820 zerocopy bugfix			(Benjamin LaHaise)
> - Fix VM problems where cache/buffers didn't get
>   freed						(me)

Will there be a rc2?

--
Daniel
