Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTFHBAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 21:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTFHBAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 21:00:11 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:1721 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S264186AbTFHBAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 21:00:07 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Christoph Hellwig <hch@lst.de>, mdharm-usb@one-eyed-alien.net
Subject: Re: 2.5.70-mm6
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<873cilz9os.fsf@lapper.ihatent.com>
	<20030607175649.6bf3813b.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 08 Jun 2003 03:13:46 +0200
In-Reply-To: <20030607175649.6bf3813b.akpm@digeo.com>
Message-ID: <87y90dfk1h.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > Andrew Morton <akpm@digeo.com> writes:
> > >
> > > [SNIP]
> > >
> > 
> > It builds nicely here and runs nicely so far, but my USB-drive still
> > blows up after a few gigs
> 
> Is that usb-storage?  There seem to have been a few reports of
> erratic behaviour lately.
> 

Indeed. Lots of the noise is from me :) You CC'ed Matthew Dharm on a
mail about it, so I tucked him in the CC here too.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
