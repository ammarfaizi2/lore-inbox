Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267760AbTBRMDG>; Tue, 18 Feb 2003 07:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTBRMDG>; Tue, 18 Feb 2003 07:03:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18192 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267760AbTBRMDF>; Tue, 18 Feb 2003 07:03:05 -0500
Date: Tue, 18 Feb 2003 13:13:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
Message-ID: <20030218121305.GF5277@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com> <20030218000304.GA7352@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218000304.GA7352@f00f.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Oh, and as a sign that 2.6.x really _is_ approaching, people have
> > started sending me spelling fixes.
> 
> FWIW, I can't get 2.5.59+ (maybe earlier) to run reliably for me
> without spontaneous rebooting under load (kernel compile in a loop).
> 
> I wondered if it was specific to my system here except a few other
> people have reported this on *very* different hardware (I'm have UP
> Athlon with IDE, they have 8-way P4 with SCSI).
> 
> Is anyone else seeing this?  Might there be some bogon causing triple
> faults or similar lurking that I'm just unlucky enough to hit often?

I'm seeing loop-related problems around 2.5.60+...
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
