Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSKUXTM>; Thu, 21 Nov 2002 18:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbSKUXTL>; Thu, 21 Nov 2002 18:19:11 -0500
Received: from mail.cafes.net ([207.65.182.3]:34964 "EHLO mail.cafes.net")
	by vger.kernel.org with ESMTP id <S265960AbSKUXTL>;
	Thu, 21 Nov 2002 18:19:11 -0500
Date: Thu, 21 Nov 2002 17:26:19 -0600
From: Mike Eldridge <diz@cafes.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc2-xfs lockups
Message-ID: <20021121172619.B13450@ornery.cafes.net>
References: <20021121153122.B13338@ornery.cafes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021121153122.B13338@ornery.cafes.net>; from diz@cafes.net on Thu, Nov 21, 2002 at 03:31:22PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 03:31:22PM -0600, Mike Eldridge wrote:
> all,
> 
> i recently replaced a pII-350 with a pair of pIII-500s in a tyan
> S1836-DLUAN-GX board (440GX dual slot 1).  i'm now getting loads of NMI
> interrupts for unknown reasons (reasons 2c and 3c).

after more googling, i've found several pieces of information that seem
to suggest interrupt routing on 440GX-based motherboards is busted.

can anyone confirm this?  will booting with 'noapic' fix this problem?
am i doomed to run a UP kernel?

-mike

[0] http://www.cs.helsinki.fi/linux/linux-kernel/2001-28/0554.html

------------------------------------------------------------------------
   /~\  the ascii                  "see, you not only have to be a good
   \ /  ribbon campaign            coder to create a system like linux,
    X   against html               you have to be a sneaky bastard too"
   / \  email!                                        -- linus torvalds
