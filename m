Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314670AbSDTRUz>; Sat, 20 Apr 2002 13:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314664AbSDTRUW>; Sat, 20 Apr 2002 13:20:22 -0400
Received: from ns.suse.de ([213.95.15.193]:14858 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314667AbSDTRTn>;
	Sat, 20 Apr 2002 13:19:43 -0400
Date: Sat, 20 Apr 2002 19:19:40 +0200
From: Dave Jones <davej@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420191940.D856@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Anton Altaparmakov <aia21@cantab.net>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020420170907.06e87550@pop.cus.cam.ac.uk> <5.1.0.14.2.20020420174422.00ad1390@pop.cus.cam.ac.uk> <E16ybpZ-0000V4-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 07:05:52PM +0200, Daniel Phillips wrote:
 > > The fact that some developers use bitkeeper has no effect on other 
 > > developers.
 > On the contrary, I think it has divided the kernel developers firmly into
 > two classes: the "ins" and the "outs".

Care to back that up with numbers ? Take another look at the statistics
Larry posted after the 2.5.8 merge. ISTR pretty much a 50/50 split of
bk merges and regular GNU patches.  Whilst a large proportion of the gnu
patches were from the largish sync I did, this ratio seems to be holding
up over every release.

 > Oh I don't disagree at all.  Bitkeeper is a big improvement over what
 > existed before.  But it is proprietary.  Which other tool in the tool chain
 > is proprietary?

Film at 11: proprietory tool used in Linux.
Maybe we should back out all those fixes the Stanford people found with
their checker ? Maybe we should back out the x86-64 port seeing as it
was (partly) done with a commercial simulator?

 > > I don't see why there should be any kind of split or anything like that. 
 > > Everything continues as before. It's just that some developers now have a 
 > > much easier life...
 > And some have a more difficult one.  So it goes.

You've not pointed out where this difficulty is yet. Apart from
developers having to wade through this same discussion every third week.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
