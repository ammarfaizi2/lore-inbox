Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422813AbWJFSWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbWJFSWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWJFSWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:22:54 -0400
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:19688 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1422813AbWJFSWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:22:54 -0400
Date: Fri, 6 Oct 2006 19:22:28 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Deepak Saxena <dsaxena@plexity.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-git] Fix ARM breakage due to no irq_regs.h
Message-ID: <20061006182228.GA19320@home.fluff.org>
References: <20061006180755.GA31679@plexity.net> <Pine.LNX.4.64.0610061112220.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610061112220.3952@g5.osdl.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 11:13:52AM -0700, Linus Torvalds wrote:
> 
> That should not really be nearly enough.
> 
> I've pushed out a more complete (but still untested) version that should 
> hopefully be closer to fixing up any irq breakage on arm.

It should get built ky Kautobuild when the next -git is
released (http://armlinux.simtec.co.uk/kautobuild/) which
should at least tell us if it builds.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
