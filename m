Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSJMVYP>; Sun, 13 Oct 2002 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJMVYP>; Sun, 13 Oct 2002 17:24:15 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:6874 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261581AbSJMVYN>;
	Sun, 13 Oct 2002 17:24:13 -0400
Date: Sun, 13 Oct 2002 22:31:33 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <20021013213133.GA11769@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <39770000.1034541701@flay> <20021013205933.GA24140@kroah.com> <48100000.1034543175@flay> <20021013211740.GC24140@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021013211740.GC24140@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 02:17:40PM -0700, Greg KH wrote:

 > > I *will* do that. Just not in time for the freeze. IMHO, that's a cleanup (and yes,
 > > a needed one).
 > 
 > Hm, IMVHO I think this should be done correctly, as a subarch, instead
 > of just patches (although your patches are split up very nicely, good
 > job, that couldn't have been very easy.)  I don't know if "Time" is a
 > good excuse to put things like this in the tree, in the format that it
 > shouldn't be.
 > 
 > But as I'm not the i386 maintainer, I'll let Linus decide that one :)

If half-arsed stuff is going to get merged just to beat the freeze,
maybe it should go in with the constraint "get it cleaned by xxx
or it gets dropped".

Personally, I agree with Greg, and that it should get fixed up
_before_ the freeze. Fixing this up to work with subarch's shouldn't
take *that* long, and there's *counts* a whole week remaining before
Linus goes on hols 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
