Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbTBRBf4>; Mon, 17 Feb 2003 20:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTBRBf4>; Mon, 17 Feb 2003 20:35:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62991 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267438AbTBRBf4>; Mon, 17 Feb 2003 20:35:56 -0500
Date: Mon, 17 Feb 2003 17:42:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
In-Reply-To: <20030218000304.GA7352@f00f.org>
Message-ID: <Pine.LNX.4.44.0302171741250.1754-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Chris Wedgwood wrote:
> 
> FWIW, I can't get 2.5.59+ (maybe earlier) to run reliably for me
> without spontaneous rebooting under load (kernel compile in a loop).
> 
> I note the 2.5.59-mjb4 seems pretty reliable and doesn't have this
> problem...

It would be interesting to hear exactly when the trouble started. And if
plain 2.5.59 does it (which is unclear from your description), but 59-mjb4
doesn't, then that's an interesting data point.

		Linus

