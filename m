Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262555AbTCIRrs>; Sun, 9 Mar 2003 12:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262556AbTCIRrs>; Sun, 9 Mar 2003 12:47:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:56502 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262555AbTCIRrr>; Sun, 9 Mar 2003 12:47:47 -0500
Date: Sun, 09 Mar 2003 09:58:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <18810000.1047232693@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0303090928570.11894-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303090928570.11894-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think it's possible to get 90% of the functionality that most of us
>> (or at least I) want without the distributed stuff.
> 
> No, I really don't think so.
> 
> The distribution is absolutely fundamental, and _the_ reason why I use BK.
> 
> Now, it's true that in 90% of all cases (probably closer to 99%) you will
> never see the really nasty cases Larry was talking about. People just
> don't rename files that much, and more importantly: then whey do, they
> very very seldom have anybody else doing the same.
> 
> But what are you going to do when it happens? Because it _does_ happen:  
> different people pick up the same patch or fix suggestion from the mailing
> list, and do that as just a small part of normal development. Are the 
> tools now going to break down?

I'm going to fix it by hand ;-) As long as it stops at a sensible point,
and clearly barfs and says what the problem is, that's fine by me.
 
> BK doesn't. That' skind of the point. Larry 

Right ... I appreciate that. I'd just rather fix things up by hand 1% of
the time than use Bitkeeper myself. I'm not trying to stop *you* using
Bitkeeper by any stretch of the imagination ... you probably need the
heavyweight tools, but I'm OK without them.

> This is FUNDAMENTAL.
> 
> And yes, maybe the really hard cases are rare. But does that mean that you 
> aren't going to do it?

Yup, that's exactly what I'm saying. I'm not saying this as good as bitkeeper,
I'm saying it's "good enough" for me and I suspect several others (not saying 
it's good enough for you), and significantly better than diff and patch.
(though cp -lR is *blindingly* fast, and diff understands hard links).

M.

