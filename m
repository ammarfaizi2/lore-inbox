Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTBQXxE>; Mon, 17 Feb 2003 18:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTBQXxE>; Mon, 17 Feb 2003 18:53:04 -0500
Received: from tapu.f00f.org ([202.49.232.129]:18830 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267274AbTBQXxD>;
	Mon, 17 Feb 2003 18:53:03 -0500
Date: Mon, 17 Feb 2003 16:03:04 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.62 --- spontaneous reboots
Message-ID: <20030218000304.GA7352@f00f.org>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 03:18:43PM -0800, Linus Torvalds wrote:

> Oh, and as a sign that 2.6.x really _is_ approaching, people have
> started sending me spelling fixes.

FWIW, I can't get 2.5.59+ (maybe earlier) to run reliably for me
without spontaneous rebooting under load (kernel compile in a loop).

I wondered if it was specific to my system here except a few other
people have reported this on *very* different hardware (I'm have UP
Athlon with IDE, they have 8-way P4 with SCSI).

Is anyone else seeing this?  Might there be some bogon causing triple
faults or similar lurking that I'm just unlucky enough to hit often?

I note the 2.5.59-mjb4 seems pretty reliable and doesn't have this
problem...




  --cw
