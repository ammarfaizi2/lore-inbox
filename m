Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbSL1WFj>; Sat, 28 Dec 2002 17:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSL1WFj>; Sat, 28 Dec 2002 17:05:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15890 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265713AbSL1WFj>; Sat, 28 Dec 2002 17:05:39 -0500
Date: Sat, 28 Dec 2002 14:08:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Simmons <jsimmons@infradead.org>
cc: Harald Dunkel <harri@synopsys.COM>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.53
In-Reply-To: <Pine.LNX.4.33.0212281449321.1725-100000@maxwell.earthlink.net>
Message-ID: <Pine.LNX.4.44.0212281405490.1693-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Dec 2002, James Simmons wrote:
> 
> Okay this problem is getting annoying. Here are a few fixes. Please apply
> Linus.

PLEASE don't send me patches like this.

The "bk send" stuff is totally unusable anyway, and it is made doubly so 
when you send BK patches that aren't even based on my tree, but have some 
other BK stuff before them, so that BK can't even take it due to missing 
parents.

Either make a real BK tree available for pulling (a _clean_ one, see the
docs), or just send real patches with no sign of BK. None of this
half-baked "bk send" crap.

Larry should never have made "bk send" available in the first place, it's 
an abomination.

		Linus

