Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbSIRQfh>; Wed, 18 Sep 2002 12:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbSIRQfg>; Wed, 18 Sep 2002 12:35:36 -0400
Received: from dsl-213-023-020-105.arcor-ip.net ([213.23.20.105]:63879 "EHLO
	starship") by vger.kernel.org with ESMTP id <S267498AbSIRQfP>;
	Wed, 18 Sep 2002 12:35:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [2.5] DAC960
Date: Wed, 18 Sep 2002 18:40:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
References: <200209181617.g8IGHgp03871@localhost.localdomain>
In-Reply-To: <200209181617.g8IGHgp03871@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17rhsI-0000Fm-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 September 2002 18:17, James Bottomley wrote:
> > > > Linus indicated at the Kernel Summit that he'd like to see a
> > > > cleaned-up scsi midlayer used as framework for *all* disk IO,
> > > > including IDE.  Obviously, what with IDE transitions and whatnot, we
> > > > are far from being ready to attempt that, so see "nursing along"
> > > > above.  There's no longer any chance that a generic disk midlayer is
> > > > going to happen in this cycle, as far as I can see.  Still, anybody
> > > > who is interested would do well by studing the issues, and fixing
> > > > broken drivers certainly qualifies as a way to come up to speed.
> > > > First of all, I believe Linus' plan is to push more functionality into
> > > the block layer.
> >
> > I distinctly heard him say he wanted the scsi mid layer repurposed as
> > an interface for all disks.  Maybe he changed his mind?
> 
> I don't recall hearing this.  I remember his agreeing with the idea of 
> slimming down the SCSI mid layer, which does rather contradict the use SCSI 
> for everything approach.

> After the Kernel Summit, there was quite a long thread on l-k with Joerg 
> Schilling on exactly this issue.

Subject line "IDE/ATAPI in 2.5"?

> The upshot of which was I clearly said we 
> weren't going to go the SCSI is everything route.  Unless there's any reason 
> to change course, I think that's the current plan.

Given that Halloween is 6 weeks away, I don't doubt you.

-- 
Daniel
