Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSGEFjz>; Fri, 5 Jul 2002 01:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSGEFjy>; Fri, 5 Jul 2002 01:39:54 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:60391 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316836AbSGEFjy>; Fri, 5 Jul 2002 01:39:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 5 Jul 2002 14:44:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15653.9247.110730.4440@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raid kdev_t cleanups (part 1)
In-Reply-To: message from Alexander Viro on Friday July 5
References: <15653.6720.628807.611023@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.21.0207050101230.14718-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 5, viro@math.psu.edu wrote:
> > could you hold off a few days until I get it
> > submitted so that I don't have to re-merge??
> 
> Damn.  I've just sent the last one raid-related one...
> 
> OK...  Mind if I do that merge?  Just send them to me, I'll do the merge
> tonight and send them back for your approval ASAP.

That's fine with me... I have 19 patches.  Some duplicate some of
yours.  Others will have substantial non-trivial rejects, largely due
to your diskop changes.

I'll send them in subsequent Emails (others can view at
http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/2.5.24a/
)

Thanks,
NeilBrown
