Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312970AbSDTRPw>; Sat, 20 Apr 2002 13:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312972AbSDTRPv>; Sat, 20 Apr 2002 13:15:51 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:20106 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S312970AbSDTRPs>;
	Sat, 20 Apr 2002 13:15:48 -0400
Date: Sat, 20 Apr 2002 13:15:47 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420131547.C3327@havoc.gtf.org>
In-Reply-To: <5.1.0.14.2.20020420170907.06e87550@pop.cus.cam.ac.uk> <5.1.0.14.2.20020420174422.00ad1390@pop.cus.cam.ac.uk> <E16ybpZ-0000V4-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 07:05:52PM +0200, Daniel Phillips wrote:
> On Saturday 20 April 2002 18:51, you wrote:
> > The fact that some developers use bitkeeper has no effect on other 
> > developers.
> 
> On the contrary, I think it has divided the kernel developers firmly into
> two classes: the "ins" and the "outs".

I disagree -- Andrew Morton and Al Viro don't sent patches to Linus via
BK, AFAIK, and their patches are getting in.

Another example, Jean Tourrhes (sp?), the wireless and IrDA guy.  I have
agreed to become his "patch penguin", which IMHO has already translated
into less resends for Jean through my and Linus's use of BK.  He sends
GNU patches, so his process is unchanged, he only sees patches _not_
getting dropped[1].

And a further counter-example (to my shame), Anton A. sent me a BK patch
during Linus's vacation, and I have not yet sent it forward, showing
that BK doesn't necessarily imply auto-approval.

	Jeff



[1] of course there is often a Garzik-delay :) but I don't drop patches
