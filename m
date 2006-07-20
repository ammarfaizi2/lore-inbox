Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWGTQL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWGTQL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWGTQLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:11:25 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:25234 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030356AbWGTQLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:11:25 -0400
Date: Thu, 20 Jul 2006 09:11:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: David Greaves <david@dgreaves.com>
Cc: Nathan Scott <nathans@sgi.com>, Kasper Sandberg <lkml@metanurb.dk>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, ml@magog.se, radsaq@gmail.com
Subject: Re: FAQ updated (was Re: XFS breakage...)
Message-ID: <20060720161121.GA26748@tuatara.stupidest.org>
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com> <1153304468.3706.4.camel@localhost> <20060720171310.B1970528@wobbly.melbourne.sgi.com> <44BF8500.1010708@dgreaves.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BF8500.1010708@dgreaves.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 02:28:32PM +0100, David Greaves wrote:

> Does this problem exist in 2.16.6.x??

The change was merged after 2.6.16.x was branched, I was mistaken
in how long I thought the bug has been about.

> I hope so because I assumed there simply wasn't a patch for 2.6.16 and
> applied this 'best guess' to my servers and rebooted/remounted successfully.

Doing the correct change to 2.6.16.x won't hurt, but it's not
necessary.
