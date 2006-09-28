Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031313AbWI1Ayo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031313AbWI1Ayo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031314AbWI1Ayo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:54:44 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:24839 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1031313AbWI1Ayn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:54:43 -0400
Date: Wed, 27 Sep 2006 20:54:28 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How long to wait on patches?
Message-Id: <20060927205428.c969984e.kernel1@cyberdogtech.com>
In-Reply-To: <20060926234505.GL4547@stusta.de>
References: <1153531563.25640@shark.he.net>
	<000401c6ad2e$a6ba0eb0$fe01a8c0@cyberdogt42>
	<20060722160924.GQ25367@stusta.de>
	<20060925105212.cf4985a7.kernel1@cyberdogtech.com>
	<20060926234505.GL4547@stusta.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Wed, 27 Sep 2006 20:54:34 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Wed, 27 Sep 2006 20:54:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 01:45:05 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Sep 25, 2006 at 10:52:12AM -0400, Matt LaPlante wrote:
> 
> > 2.6.18 is out, so I feel the urge to revive a dead topic. :) Any idea when we might get my ancient trivials included in the new gits?  I'm still lurking around and ready to do more pointless doc-checking tasks, but I really want the old stuff merged so I can rebase around it.
> >...
> 
> During the 2 weeks until 2.6.19-rc1.
> 
> It wouldn't be good if I'd forward all the trivial patches today 
> probably breaking the context for pending merges.

Alright, good to know.  If I may suggest:

99% of my changes are to text Docs, not source.  I don't believe we would be risking code breakage as a result of merging them.  In this case of course I don't expect you to root through the trivial box and pull out my patches, but maybe this isn't the best way for me to submit them in the first place?  It seems like a particularly small and unnecessary window for somebody to update text files in.  Is there a different tree or maintainer that would be better suited for this type of thing?

Thanks again.

-
Matt

> 
> cu
> Adrian
> 


