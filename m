Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTHYDjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbTHYDjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:39:18 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51077
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261464AbTHYDjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:39:12 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: "Randy.Dunlap" <rddunlap@osdl.org>, Daniel Pezoa <dpforos@yahoo.com>
Subject: Re: patches question
Date: Sun, 24 Aug 2003 01:11:58 -0400
User-Agent: KMail/1.5
Cc: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0308191339430.1464-100000@coffee.psychology.mcmaster.ca> <20030820155956.67452.qmail@web11201.mail.yahoo.com> <20030820093347.4f024a89.rddunlap@osdl.org>
In-Reply-To: <20030820093347.4f024a89.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308240111.58758.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 August 2003 12:33, Randy.Dunlap wrote:
> On Wed, 20 Aug 2003 08:59:56 -0700 (PDT) Daniel Pezoa <dpforos@yahoo.com> 
wrote:
> | sorry but i think the faq is incomplete, i think
> | useless for what i need too. It have incomplete
> | answers  and not links references for many important
> | questions. May be should exist one list or forum
> | dedicated to: Kernel, Kernel Patches, Kernel Modules,
> | Kernel Drives and other about Kernel Development and
> | Bugs Report.
>
> The LKML FAQ hasn't been updated since:
> "Last updated on 21 Nov 2002 by Richard Gooch.
> This document is GPL'ed by its various contributors."
>
> and Richard hasn't been heard from lately AFAIK.
>
> I would have just guessed that the FAQ needs some updates...
> Doesn't someone out there want a job?

I've been meaning to give the FAQ a thorough going over for a while now.  
(Bits of it are a lot more stale than 2002.)

I sent Richard a FAQ patch a month ago, which he hasn't responded to, but he 
claims to still be active:

> > Okay, that link needs to go in the "basic linux kernel
> > documentation" section at the start of the
> > "http://www.tux.org/lkml/" faq, along with some other resources that
> > have fallen through the cracks.  I'd happily generate a patch
> > against the FAQ, but haven't a clue what the source format is.  (Is
> > it hand-hacked HTML?)
>
> Yes. A plain uni-diff against the HTML will be fine. I'm busy these
> days, so don't expect a quick response. But I will get around to it.
>
>                               Regards,
>
>                                       Richard....

I sent him the patch in question on July 17th, but haven't heard anything 
back.  (I've been a bit out of touch in the past month myself getting back 
into grad school, buying a condo, moving, etc, and haven't followed up yet.)

If Richard doesn't have time to do it anymore, and there are patches backing 
up, I could give it a whack.  I'm not exactly dripping with free time myself 
at the moment, but I usually catch up with all the important pending things 
at least once a week.  However, I don't want to usurp anybody's 
maintainership.  (I was planning on possibly making my own tree and then 
feeding him incremental patches at whatever rate he responds...)

Rob


