Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273051AbTHFBjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 21:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273052AbTHFBjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 21:39:45 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:128 "EHLO dust")
	by vger.kernel.org with ESMTP id S273051AbTHFBjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 21:39:44 -0400
Date: Tue, 5 Aug 2003 20:43:25 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: svein@brage.info
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-tst2-mm4 and ide-scsi
In-Reply-To: <20030806013125.GB5962@brage.info>
Message-ID: <Pine.LNX.4.56.0308052041560.3753@dust>
References: <871xw1kyu2.fsf@lapper.ihatent.com> <Pine.LNX.4.56.0308041520540.3506@dust>
 <20030806013125.GB5962@brage.info>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 svein@brage.info wrote:

> > [Snip]
> > 
> > Tried burning without ide-scsi?  As long as you have a recent enough
> > version of cdrtools, ide-scsi is no longer necessary in 2.5/2.6.  I
> > haven't used ide-scsi in months, and CD burning works just fine.
> 
> Well, then, what about cdrdao?
> I sometimes need to make more exact copies of a CD than cdrtools allows,
> and cdrdao doesn't seem top support IDE devices yet.

I'm pretty much positive that cdrecord has a disk at once version that 
doesn't make anything explode.

-- 
Alex Goddard
agoddard@purdue.edu
