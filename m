Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVDDOT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDDOT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVDDOT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:19:58 -0400
Received: from smtp12.wanadoo.fr ([193.252.22.20]:173 "EHLO smtp12.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261230AbVDDOTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:19:55 -0400
X-ME-UUID: 20050404141954585.8ED521C0008E@mwinf1201.wanadoo.fr
Date: Mon, 4 Apr 2005 16:16:47 +0200
To: Michael Poole <mdpoole@troilus.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404141647.GA28649@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87ekdq1xlp.fsf@sanosuke.troilus.org>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 09:26:58AM -0400, Michael Poole wrote:
> Sven Luther writes:
> 
> > Hello,
> >
> > <quick sumary>
> > Current linux kernel source hold undistributable non-free firmware blobs, and
> > to consider them as mere agregation, a clear licence statement from the
> > copyright holders of said non-free firmware blobls is needed, read below for
> > details.
> > </quick sumary>
> >
> > Please keep everyone in the CC, as not everyone reads debian-legal or LKML.
> 
> This question comes up every four or five months.  You might have even
> been the last one to raise this question on one or more of the mailing
> lists you cc'ed.  Please, go check the list archives for the previous
> (lengthy and multiple) discussions about this topic.

Sure, i raised this the last time, and it was discussed on debian-legal and
debian-kernel, and since nobody objected, and many where in accord with my
arguments in that thread i linked in the parent post, i believe consensus was
reached. This is basically the position debian has, and work has already been
started to move some of the affected modules in a separate package, which will
be distributed from non-free.

This is just the followup on said discussion, involving the larger LKML
audience, in order to get this fixed for good. As said, it is just a mere
technicality to get out of the muddy situation, all the people having
contributed source-less firmware blobs, need to give us (us being debian, but
also all the linux kernel community) either the source if they persist in
distributing the code under the GPL, or a clear distribution licence for these
firmware blobs, and clearly identificate them as not covered by the GPL that
the file they come in is.

Discussing legal issues is all cool and nice for those that appreciates such
sport, but it doesn't really make sense if it is not applied to acts later on.

Friendly,

Sven Luther

