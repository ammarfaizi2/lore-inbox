Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274804AbRIUT6M>; Fri, 21 Sep 2001 15:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274805AbRIUT6B>; Fri, 21 Sep 2001 15:58:01 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:55821 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274804AbRIUT5q>; Fri, 21 Sep 2001 15:57:46 -0400
Date: Fri, 21 Sep 2001 15:58:06 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Whats in the wings for 2.5 (when it opens)
Message-ID: <20010921155806.B8188@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010918001826.7D118A0E5@oscar.casa.dyndns.org> <20010918214904.B29648@vdpas.hobby.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010918214904.B29648@vdpas.hobby.nl>; from toon@vdpas.hobby.nl on Tue, Sep 18, 2001 at 09:49:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 18/09/01 21:49 +0200 - toon@vdpas.hobby.nl:
> On Mon, Sep 17, 2001 at 08:18:25PM -0400, Ed Tomlinson wrote:
> > Hi,
> > 
> > Seems like there is a lot of code "ready" for consideration in a 2.5 kernel.
> > I can think of:
> > 
> > premptable kernel option
> > user mode kernel 
> > jfs
> > xfs (maybe)
> 
> ext3
> 
> > rc2
> > reverse maping vm
> > ide driver rewrite
> > 32bit dma
> > LTT (maybe)
> > LVM update to 1.01
> 
> My opinion is that the LVM update to 1.01 should go into 2.4
> as soon as possible.
> 
> > ELVM (maybe)
> > module security stuff
> > UP friendly SMP scheduler
> > 
> > What else?
> > 
> > TIA
> > Ed Tomlinson

A cleaner handling of module parameters/cmd line options.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
