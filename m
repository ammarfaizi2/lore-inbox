Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314706AbSDVTyV>; Mon, 22 Apr 2002 15:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314715AbSDVTyU>; Mon, 22 Apr 2002 15:54:20 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18381 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314706AbSDVTyD>; Mon, 22 Apr 2002 15:54:03 -0400
Date: Mon, 22 Apr 2002 15:53:57 -0400
From: Doug Ledford <dledford@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Larry McVoy <lm@bitmover.com>, Ian Molton <spyro@armlinux.org>,
        linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020422155357.B877@redhat.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Larry McVoy <lm@bitmover.com>, Ian Molton <spyro@armlinux.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204202108410.10137-100000@home.transmeta.com> <E16zK5f-0001He-00@starship> <20020422101750.D17613@work.bitmover.com> <E16zLEf-0001I7-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 07:34:49PM +0200, Daniel Phillips wrote:
> How about a URL instead?  Any objection?

Yes.  Why should I have to cut and paste (assuming I'm in X) or
write down and transpose some URL from a file that used to contain
the exact instructions I need in order to get those instructions now just
to satisfy your sensitivity?  (And let's not get me started on
"sensitivity" and how personally I think that it's nothing more than a
politically correct way of saying "I don't want to hear what you have to
say so shut up" and is nothing more than another form of censorship that
should be beaten out of all children until it is once and for all
eliminated from this earth)

So let me tell a little story for a second.  I used to maintain the 
aic7xxx driver.  In so doing, I created a web site for disseminating my 
patches and what not.  As people would grab my patches, I would get 
regular (and annoying to me) questions like "how do I apply your 
patches", "what patch version should I grab", "how do I compile my 
kernel after I apply your patch," etc.  So, after enough of the same 
question, the question itself becomes a "frequently asked question".  So, 
I made a few docs that attempted to answer these questions and put them on 
my web site along side the patches themselves.  These docs most generally 
described how the linux kernel versioning worked, how my patch versioning 
worked, how to select patches, how to use the patch command, etc.  Now, 
obviously, some of this was very aic7xxx specific, but large parts of it 
were background knowledge that was required in order to apply that 
specific aic7xxx information.  It made sense therefore to include that 
information so that the whole picture, from start to finish, was all 
described in one easy to access place.  So, as a result, even though I 
could have pointed the reader to the patch man page, I didn't bother to 
make them read a large document full of options and possible means of 
screwing things up when all I really wanted them to know was "All of my 
patches are generated so that if you go into the top level of the linux 
source directory and type 'patch -p1 < patchname' then things will work 
properly".

So, I haven't read this "BitKeeper advertisement" you have been 
complaining about.  However, I have heard claims that it deals more 
specifically with how to interface your own personal BK setup with Linus 
than it does with usage of BK in general.  If I were to sit down and read 
that document now, the questions I would attempt to answer would be things 
like A) does it describe BK in general and how to set it up for general 
use, or does it describe how to set BK up for a specific use related to 
kernel developement, B) does it describe how that setup is then integrated 
into a kernel patch submission process, C) is the description relevant 
to all BK setups (not just linux kernel setups) or is it geared 
specifically towards linux kernel setups, and D) would the description of 
BK found in the document be of general use to BK deployments in evil 
proprietary company "X" or would evil company "X" likely need a more 
general description of BK capabilities not as it is related to linux 
kernel development.  From those questions, and possibly a few more similar 
ones, a person can determine if the document belongs on the BK web site, 
or in the linux documentation directory.

Like I said, I haven't read the document.  But, if I did and it turned out 
that it was similar to my description of how to use patch to apply my 
aic7xxx patches, IOW if it truly was a limited scope "How to use BK to 
send patches to Linus" and provided just the needed BK information to 
teach the user the real goal, which is how to integrate their work into 
Linus' BK patch process, then I would be greatly offended should the 
document be moved out it's appropriate location in the linux kernel 
documentation directory to some web site where it doesn't really belong.  


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
