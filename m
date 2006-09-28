Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031315AbWI1BBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031315AbWI1BBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031316AbWI1BBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:01:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031315AbWI1BBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:01:45 -0400
Date: Thu, 28 Sep 2006 03:01:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How long to wait on patches?
Message-ID: <20060928010140.GC3305@stusta.de>
References: <1153531563.25640@shark.he.net> <000401c6ad2e$a6ba0eb0$fe01a8c0@cyberdogt42> <20060722160924.GQ25367@stusta.de> <20060925105212.cf4985a7.kernel1@cyberdogtech.com> <20060926234505.GL4547@stusta.de> <20060927205428.c969984e.kernel1@cyberdogtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927205428.c969984e.kernel1@cyberdogtech.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 08:54:28PM -0400, Matt LaPlante wrote:
> On Wed, 27 Sep 2006 01:45:05 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > On Mon, Sep 25, 2006 at 10:52:12AM -0400, Matt LaPlante wrote:
> > 
> > > 2.6.18 is out, so I feel the urge to revive a dead topic. :) Any idea when we might get my ancient trivials included in the new gits?  I'm still lurking around and ready to do more pointless doc-checking tasks, but I really want the old stuff merged so I can rebase around it.
> > >...
> > 
> > During the 2 weeks until 2.6.19-rc1.
> > 
> > It wouldn't be good if I'd forward all the trivial patches today 
> > probably breaking the context for pending merges.
> 
> Alright, good to know.  If I may suggest:
> 
> 99% of my changes are to text Docs, not source.  I don't believe we would be risking code breakage as a result of merging them.  In this case of course I don't expect you to root through the trivial box and pull out my patches, but maybe this isn't the best way for me to submit them in the first place?  It seems like a particularly small and unnecessary window for somebody to update text files in.  Is there a different tree or maintainer that would be better suited for this type of thing?

I'm not talking about breaking code, I'm talking about breaking
_patch context_.

I have no problem with you sending your patches through subsystem 
maintainers or Andrew.

> Thanks again.
> Matt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

