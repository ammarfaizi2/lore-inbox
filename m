Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135404AbRDRWNB>; Wed, 18 Apr 2001 18:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135365AbRDRWMy>; Wed, 18 Apr 2001 18:12:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45696 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135404AbRDRWMn>;
	Wed, 18 Apr 2001 18:12:43 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15070.4428.345455.994818@pizda.ninka.net>
Date: Wed, 18 Apr 2001 15:12:28 -0700 (PDT)
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: ANNOUNCE New Open Source X server
In-Reply-To: <Pine.LNX.4.10.10104181317440.1478-100000@www.transvirtual.com>
In-Reply-To: <Pine.LNX.4.10.10104181317440.1478-100000@www.transvirtual.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Simmons writes:
 >     The Linux GFX project grew out the need for a higher performance X
 > server that has a much faster developement cycle. In the last few years
 > the graphics card and multimedia environments have grow at such a rate 
 > the current X solutions can no longer keep pace nor do they focus on
 > producing high performance X servers specifically for linux. Also the
 > community has demanded for specific functionality which has never come to
 > light. 

And this specific functionality is?

I think this is not a worthwhile project at all.  The X tree, it's
assosciated protocols and APIs, are complicated enough as it is, and
the xfree86 project has some of the most talented and capable people
in this area.  It would be a step backwards to do things outside of
xfree86 development.

If the issue is that "things don't happen fast enough in the xfree86
tree", why not lend them a hand and submitting patches to them instead
of complaining?

Later,
David S. Miller
davem@redhat.com
