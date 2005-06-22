Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVFVPfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVFVPfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVFVPce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:32:34 -0400
Received: from [80.71.243.242] ([80.71.243.242]:43471 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261458AbVFVP3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:29:40 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.33766.343219.30650@gargle.gargle.HOWL>
Date: Wed, 22 Jun 2005 19:29:42 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Newsgroups: gmane.comp.file-systems.reiserfs.general,gmane.linux.kernel
In-Reply-To: <42B8D131.6060502@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>
	<42B831B4.9020603@pobox.com.suse.lists.linux.kernel>
	<42B87318.80607@namesys.com.suse.lists.linux.kernel>
	<20050621202448.GB30182@infradead.org.suse.lists.linux.kernel>
	<42B8B9EE.7020002@namesys.com.suse.lists.linux.kernel>
	<42B8BB5E.8090008@pobox.com.suse.lists.linux.kernel>
	<p73fyvbb2rh.fsf@verdi.suse.de>
	<42B8D131.6060502@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > Andi Kleen wrote:
 > 
 > > Christoph does a lot of reviewing 
 > >
 > and he is notorious for making needed linux contributors go away and not
 > come back, and I won't say which famous person on this mailing list told
 > me that....
 > 
 > >and your child definitely
 > >is in serious need of that to be mergeable. I'm sure Christoph is able
 > >to review inpartially even when he is involved with other FS.
 > >  
 > >
 > As impartial as a puppy on PCP....
 > 
 > Christoph is aggressive about things he does not take the time to
 > understand or ask about first.  I hate that.   I wish he would go away
 > please.  He is not exactly an Ousterhout, Rob Pike, Granger, Mazieres,
 > Frans Kaashoek, etc.,  in his accomplishments, so why is he reviewing
 > other people's filesystems?  Reviews are great, how about finding
 > persons who have created filesystem innovations (and thus are less
 > likely to reject innovations without understanding them) to do them? 

Well, because of his classy hair-style of course.

Seriously, Linux is not managed by a committee. There is nobody to
appoint Official File System Reviewers of Her Majesty. Everything here
(including your credentials as a file system designer) is
self-proclaimed.

 > 
 > How about review by benchmark instead?

[...]

 >                                   I frankly think that with my
 > benchmarks, I should be allowed to tinker on my own. 

I am afraid it will sound picky, but 10 month ago you said you are
planning to replace benchmarks on the namesys.com with fairer ones:

http://marc.theaimsgroup.com/?l=reiserfs&m=109368686019301&w=2

Last time I checked, http://namesys.com/benchmarks.html still features
only mongo runs with overwrite/modify phases off and with all operations
done in readdir order (most favorable mode for reiser4).

 >
 > Hans The Mad
 > 

Nikita.
