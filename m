Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSHVH5D>; Thu, 22 Aug 2002 03:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHVH5C>; Thu, 22 Aug 2002 03:57:02 -0400
Received: from cibs9.sns.it ([192.167.206.29]:15885 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S318009AbSHVH5C>;
	Thu, 22 Aug 2002 03:57:02 -0400
Date: Thu, 22 Aug 2002 10:00:39 +0200 (CEST)
From: venom@sns.it
To: Kelsey Hudson <khudson@compendium.us>
cc: James Bourne <jbourne@mtroyal.ab.ca>, Hugh Dickins <hugh@veritas.com>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading
In-Reply-To: <Pine.LNX.4.44.0208211414190.6621-100000@betelgeuse.compendium-tech.com>
Message-ID: <Pine.LNX.4.43.0208220958370.7650-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Kelsey Hudson wrote:

> Date: Wed, 21 Aug 2002 14:16:11 -0700 (PDT)
> From: Kelsey Hudson <khudson@compendium.us>
> To: James Bourne <jbourne@mtroyal.ab.ca>
> Cc: Hugh Dickins <hugh@veritas.com>,
>      "Reed, Timothy A" <timothy.a.reed@lmco.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Hyperthreading
>
> On Wed, 21 Aug 2002, James Bourne wrote:
>
> > On Wed, 21 Aug 2002, Hugh Dickins wrote:
> >
> > > You do need CONFIG_SMP and a processor capable of HyperThreading,
> > > i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> > > just appropriate to that processor in other ways.
> >
> > I was under the impression that the only CPU capable of hyperthreading was
> > the P4 Xeon.  Is this not correct?  I don't know of any other CPUs that
> > have the ht feature.
>
> This is currently correct, although I believe Intel has plans to release a
> Hyperthreading-capable version of its desktop P4.

basically all PIV are capable of hyperthreading, non just Xeon, but it is
disabled and there is not way to enable it in Bios, so the most hang at
boot when you try to activate hyperthreading on them




