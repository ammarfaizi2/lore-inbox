Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316423AbSEOPuw>; Wed, 15 May 2002 11:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316422AbSEOPuv>; Wed, 15 May 2002 11:50:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5125 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316423AbSEOPuu>; Wed, 15 May 2002 11:50:50 -0400
Date: Wed, 15 May 2002 11:47:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac4
In-Reply-To: <200205151433.g4FEXko20788@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1020515114553.5224A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Alan Cox wrote:

> The usual IDE merge comments apply. Please treat this tree with care.
> It should have knocked out more of the weirdnesses as well as providing the
> basis for upcoming restructuring of stuff for mmio etc.
> 
> 
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.19pre8-ac4

Do note that this patch is against 2.4.18, not 2.4.19-pre8. At least
according to the diff of the top level Makefile.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

