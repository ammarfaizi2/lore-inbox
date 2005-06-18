Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVFRP6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVFRP6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 11:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVFRP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 11:58:07 -0400
Received: from dvhart.com ([64.146.134.43]:12459 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262138AbVFRP6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 11:58:02 -0400
Date: Sat, 18 Jun 2005 08:58:00 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: kernel bugzilla
Message-ID: <141740000.1119110279@[10.10.2.4]>
In-Reply-To: <20050618154532.GR21393@stusta.de>
References: <20050617001330.294950ac.akpm@osdl.org> <1119016223.5049.3.camel@mulgrave> <20050617142225.GO6957@suse.de> <20050617141003.2abdd8e5.akpm@osdl.org> <20050617212338.GA16852@suse.de> <20050617143946.00f387d0.akpm@osdl.org> <20050618154532.GR21393@stusta.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > One thing I haven't worked out is how to get a bug which is initially
>> > > reported via email *into* the bugzilla system for tracking purposes.  One
>> > > could just ask the originator to raise a bugzilla entry, as lots of other
>> > > projects do.  But I don't think we want to do that - it's in our interest
>> > > to make bug reporting as easy as possible for the reporter, rather than
>> > > putting up barriers.
>> > 
>> > Depends... Sometimes it's quite ok to put the onus on the reported to
>> > file it in bugzilla, since it should be considered in his best interest
>> > to do so - he obviously filed the bug, because the issue bothers him in
>> > some way. As long as it is 'easy enough' to do so, I think we are
>> > alright. The question is if this can't be automated fairly easily. A
>> > good bugzilla interface helps a _lot_.
>> 
>> Agree.  We should encourage people to use bugzilla as the initial
>> entry-point.  But if someone instead uses email as the first contact I'm
>> just a little bit reluctant to say "thanks, now go and try again".
>> 
>> Perhaps we could find some nice volunteer (hint) who could take the task of
>> transferring such reports into bugzilla.  There wouldn't be very many, really.
>> ...
> 
> Why does this has to be done manually?
> 
> Reporting a bug in a Bugzilla only requires creating an account (if you 
> don't have one) and entering the bug. It's not a "do it again", since 
> the user already has the whole contents of the bug report. If you've 
> written an email with a good bug report pasting it into a Bugzilla 
> shouldn't be a problem.

The manual steps I see are filling in the fields other than problem
description - version, category, and subcategory, in particular ...
 
> The big problem for users of many bug tracking systems (including the 
> kernel Bugzilla) is not that bug reporting was too hard. The problem is 
> that bugs aren't handled in time.

Agreed.

M.
