Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbTKCTfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 14:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTKCTfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 14:35:46 -0500
Received: from dsl093-039-041.pdx1.dsl.speakeasy.net ([66.93.39.41]:44260 "EHLO
	raven.beattie-home.net") by vger.kernel.org with ESMTP
	id S263119AbTKCTfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 14:35:39 -0500
Subject: Re: Things that Longhorn seems to be doing right
From: Brian Beattie <beattie@beattie-home.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200311021715.hA2HFXr5026778@turing-police.cc.vt.edu>
References: <1067778693.1315.76.camel@kokopelli> 
	<200311021715.hA2HFXr5026778@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Nov 2003 14:35:35 -0500
Message-Id: <1067888137.869.26.camel@kokopelli>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-02 at 12:15, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 02 Nov 2003 08:11:32 EST, Brian Beattie <beattie@beattie-home.net>  said:
> 
> > for storage might be feasible soon.  The idea is that you have a
> > permanent store, using raid or raid-like redundancy and file versioning
> > so that nothing is ever deleted, you just keep adding drives and
> > replacing those that fail.  Of course you'd need some geographic
> > diversity and a way for storage to migrate to newer "file stores" to
> > really work, but just think, no more backups to fail...ever!   
> 
> This may be very nice for the high end, but getting "geographic diversity"
> means you have to get space in a colo of some sort (unless you're a big enough
> site that you have another building of your own at least a mile or two away),
> and bandwidth between the two sites.

I don't know about anytime soon and it woudl be a real paradyne(sp?)
shift.  As it is right now home many home users do backups ate all.  The
replication could well be rather low bandwidth, more to CYA in the event
of a fire of natural disaster, and really a secondary issue.  What
intriques me, is the notion of a permanent file store that is never
deleted.

I have no idea if this will every make sense, but I notice, that I
always have more disk than will fit on any backup media I can afford. 
So this is really just a "what if?" thought.

-- 
Brian Beattie            | Experienced kernel hacker/embedded systems
beattie@beattie-home.net | programmer, direct or contract, short or
www.beattie-home.net     | long term, available immediately.

"Honor isn't about making the right choices.
It's about dealing with the consequences." -- Midori Koto

