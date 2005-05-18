Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVERWPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVERWPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVERWPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:15:54 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.143]:40473 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S262345AbVERWPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:15:45 -0400
Date: Wed, 18 May 2005 17:15:40 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@suse.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050518221540.GK2596@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <20050513132945.GB16088@wotan.suse.de> <20050513155241.GA3522@redhat.com> <20050518220120.GJ2596@hygelac> <20050518220356.GC1250@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518220356.GC1250@wotan.suse.de>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 18 May 2005 22:15:47.0792 (UTC) FILETIME=[2488C500:01C55BF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 12:03:56AM +0200, ak@suse.de wrote:
> > right now I think there were a lot of excessive printouts for
> > debugging purposes. I also have no doubts that there are coding style
> > differences that need to be cleaned up (feel free to tell me when my code
> > sucks or isn't up to style).
> 
> Perhaps should concentrate on the basic design first.

sure, feel free to tell me if that sucks as well :)

> > on a side note, last I was working on this I still had to keep an
> > extra tree around and manually diff things, which is a burden and easy
> > to goof things up. is there an easier way to do this? it looks like
> > you guys are experimenting with git, is there an faq on how to get
> > started with that?
> 
> I use quilt (http://quilt.sourceforge.net) for keeping patchkits.
> Works well. It is not a real SCM, but can be combined with one.

thanks, I'll take a look at that.

Thanks,
Terence

