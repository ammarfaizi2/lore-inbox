Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbRL2UCN>; Sat, 29 Dec 2001 15:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285384AbRL2UCD>; Sat, 29 Dec 2001 15:02:03 -0500
Received: from cp912944-a.mtgmry1.md.home.com ([24.38.248.2]:51943 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S285398AbRL2UBw>;
	Sat, 29 Dec 2001 15:01:52 -0500
Date: Sat, 29 Dec 2001 15:01:52 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229150152.A10678@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011229190600.2556C36DE6@hog.ctrl-c.liu.se> <Pine.LNX.4.43.0112291313160.18183-100000@waste.org> <20011229113749.D19306@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011229113749.D19306@work.bitmover.com>; from lm@bitmover.com on Sat, Dec 29, 2001 at 11:37:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 11:37:49AM -0800, Larry McVoy wrote:
> One way to quantify this is to ask Linus, Alan, Marcelo, et al, how much
> time they spend merging, i.e., how often do they get patch rejects?
> Regardless of the answer, it will be interesting.  If it is a lot,
> then the patchbot idea has marginal usefulness.  If it is none at all,
> then that says development is serialized, which means we may be leaving
> a lot of progress on the floor.

I personally think the merging is distributed, and done by each
subsystem maintainer.  When that doesn't happen, and the merge is
non-trivial, we often see a message by Linus essentially saying "your
patch is cool, but it conflicts with another patch by <foo> that does
<bar>, so I've done a new pre with <foo>'s patch, could you merge and
rediff against it?".

  OG.
