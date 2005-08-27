Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVH1AnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVH1AnH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 20:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVH1AnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 20:43:07 -0400
Received: from ns1.osuosl.org ([140.211.166.130]:5093 "EHLO ns1.osuosl.org")
	by vger.kernel.org with ESMTP id S1751014AbVH1AnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 20:43:05 -0400
Date: Sat, 27 Aug 2005 12:42:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Micheal Marineau <marineam@engr.orst.edu>
Cc: linux-kernel@linux.kernel.org, benhbenh@kernel.crashing.org
Subject: Re: [PATCH] Radeonfb acpi vgapost
Message-ID: <20050827104240.GA3141@elf.ucw.cz>
References: <43104005.3040602@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43104005.3040602@engr.orst.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is a cleaned up version of the patch to repost radeon cards when
> resuming from acpi s3 suspend.  I've been sitting on it for a while
> hoping that I might be able to gain some insight in how to use the d2
> state instead of this repost as ppc does.  On my x86 laptop with a
> radeon 9000 resuming from d2 does manage to turn on the card/display,
> but it becomes horridly scrambled. But right now I don't have the time
> or the skill to actually get any futher than that.

Patch looks good to me. Could we get that one in, pretty please?
[Probably generic sleep parts through akpm, radeonfb parts through
ben?]

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
