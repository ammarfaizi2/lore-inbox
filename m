Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUFKNqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUFKNqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 09:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUFKNqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 09:46:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:24197 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263932AbUFKNqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 09:46:49 -0400
Date: Fri, 11 Jun 2004 15:46:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Dave Jones <davej@redhat.com>, Chris Mason <mason@suse.com>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040611134621.GA3633@wohnheim.fh-wedel.de>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com> <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com> <20040610223532.GB3340@wohnheim.fh-wedel.de> <40C91DA0.6060705@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C91DA0.6060705@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 June 2004 19:49:04 -0700, Hans Reiser wrote:
> Jörn Engel wrote:
> 
> >It appears to me that most developers agree to the two point above,
> >but you have some problems with them, at least lately.  Am i wrong?
> 
> This is all part of what responsible release management is about.   I 
> was the junior whiz kid in professional release management teams before 
> starting Namesys.  I listened to my elders and learned from them.  My 
> standards for professional conduct in this arena are higher than yours 
> as a result of that. 
> 
> You are a bunch of young kids who lack professional experience in 
> release management.  That is ok, but don't get aggressive about it.
> 
> I have no desire to pay for your mistakes, and as the official 
> maintainer it is my responsibility to ensure that neither I nor the 
> users pay for the mistakes of those who add bugs to stable branches 
> instead of adding them to the development branches where they belong.

Well, this ain't OpenBSD.  They have a strict 6month release schedule,
so your type of development works just fine for them.  Linux has
something like a very relaxed 24month+ release "schedule", which is
far too long for some people.  As a result, the Linux "stable" kernel
is a lot less stable than the OpenBSD one.

But long release cycles also have their advantages and - most
important - they work with Linus.  So effectively, we all have to
accept them and deal with the consequenses.  I really understand and
partially share your doubts, but what does it help? ;)

Jörn

-- 
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
