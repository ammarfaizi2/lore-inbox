Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263933AbTCWVoL>; Sun, 23 Mar 2003 16:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263934AbTCWVnA>; Sun, 23 Mar 2003 16:43:00 -0500
Received: from franka.aracnet.com ([216.99.193.44]:45788 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263933AbTCWVmP>; Sun, 23 Mar 2003 16:42:15 -0500
Date: Sun, 23 Mar 2003 13:53:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org
cc: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, szepe@pinerecords.com,
       arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <920000.1048456387@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz><200303231938.h2NJcAq14927@devserv.devel.redhat.com><20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org><20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org><402760000.1048451441@[10.10.2.4]> <20030323203628.GA16025@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I do already host patches for current kernels which I use at work.  What
> about just keeping a combined security and fixup patch set for the current
> tree available for people to download and apply with instructions on doing
> so and an index of what the patch contains and why? 
> 
> Given that the patches come from reputable sources (for example the ext3
> patches for 2.4.20 and the ptrace patch) they can be
> included without too much thought and some testing.  I could
> maintain this, and it could be available either on kernel.org or just from
> my website, no matter either way.  As I said, I'm already doing this so it
> wouldn't be a huge bother anyway.
> 
> If anyone wants this to happen, let me know as it will then happen... 
> Otherwise I'll continue to do it as I am now anyway, and everyone
> is welcome to use this source for patches to the current tree.

I think this would be valuable .. the other thing that really needs to
be present is a "common vendor" kernel where changes that are common
to most distros are merged (eg O(1) scheduler, etc). Personally, I think 
that's what mainline should be doing ... but if other people disagree,
then I, at least, would see value in a separate tree to do this.

M.

