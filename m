Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261592AbTCKU2k>; Tue, 11 Mar 2003 15:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbTCKU2k>; Tue, 11 Mar 2003 15:28:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:65459 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261592AbTCKU2i>; Tue, 11 Mar 2003 15:28:38 -0500
Date: Tue, 11 Mar 2003 12:29:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: phillips@arcor.de, zbrown@tumblerings.org, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <26420000.1047414550@flay>
In-Reply-To: <20030311120824.2f5a7374.akpm@digeo.com>
References: <200303020011.QAA13450@adam.yggdrasil.com><20030311184043.GA24925@renegade><22230000.1047408397@flay><20030311192639.E72163C5BE@mx01.nexgo.de><24360000.1047411221@flay> <20030311120824.2f5a7374.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> At the moment, I slap the patches back on top of every new version
>> >> seperately, which works well, but is a PITA.
>> > 
>> > Tell me about it.
>> 
>> Well, it normally only takes me an hour per release.
> 
> Whoa.  You need better tools.
> 
> A bunch of fine people took patch-tools and turned them into a real project. 
> They have .deb's and .rpm's, but it looks like they're a bit old and a `cvs co'
> is needed.  I'm still using the old stuff, but I'm sure theirs is better.
> 
> See http://savannah.nongnu.org/projects/quilt/

I did take a look at your stuff in the past ... had a few minor objections
at the time, but have actually grown closer to what you do since then.
I *do* like the numbering of my patches though. I might try to merge them
together at some point soon.

So when I say 1 hour ... bear in mind I don't take Linus bk-drops normally,
on the full releases, so the delta is bigger (and I'm slower than you! ;-))
You still have to fix up the rejects from 'patch -p1' by hand though,
right? That's what normally takes most of the time, especially if it's
code I'm unfamiliar with, or I make a mistake (reboot takes 5-10 mins ;-))

M.

