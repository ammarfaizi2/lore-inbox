Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310533AbSCGUww>; Thu, 7 Mar 2002 15:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310531AbSCGUwf>; Thu, 7 Mar 2002 15:52:35 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:59403 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S310535AbSCGUwC>;
	Thu, 7 Mar 2002 15:52:02 -0500
Date: Wed, 6 Mar 2002 12:59:01 +0000
From: Pavel Machek <pavel@suse.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
Message-ID: <20020306125900.B81@toy.ucw.cz>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <20020304050450.GF353@matchmail.com> <20020303223103.J4188@lynx.adilger.int> <3C8308FE.FC4FA42@mandrakesoft.com> <20020303231851.N4188@lynx.adilger.int> <3C838C89.5060602@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C838C89.5060602@namesys.com>; from reiser@namesys.com on Mon, Mar 04, 2002 at 06:02:33PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ReiserFS V3 is pretty stable right now.   Fsck is usually the last thing 
> to stabilize for a filesystem, and we were no exception to that rule.
> 
> ReiserFS V3 will last for probably another 3 years (though it will 
> remain supported for I imagine at least a decade, maybe more), with V4 
> gradually edging it out of the market as V4 gets more and more stable. 
>  During at least the next year we will keep some staff adding minor 
> tweaks to V3.  For instance, our layout policies will improve over the 
> next few months, journal relocation is about to move from Linux 2.5 to 
> 2.4, and data write ordering code is being developed by Chris.  I don't 
> know how long fsck maintenance for V3 will continue, but it will be at 
> least as long as users find bugs in it.  

When you think youer fsck works, let me know. I have some tests to find
bugs in fsck....
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

