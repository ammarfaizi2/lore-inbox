Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbTAGAGz>; Mon, 6 Jan 2003 19:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTAGAGz>; Mon, 6 Jan 2003 19:06:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267212AbTAGAGx>;
	Mon, 6 Jan 2003 19:06:53 -0500
Date: Mon, 6 Jan 2003 16:12:05 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andrew Morton <akpm@digeo.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configurable LOG_BUF_SIZE (updated)
In-Reply-To: <Pine.LNX.4.33L2.0301061555320.15416-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0301061611160.15416-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Randy.Dunlap wrote:

| On Mon, 6 Jan 2003, Andrew Morton wrote:
|
| | "Randy.Dunlap" wrote:
| | >
| | > ...
| | >  21 files changed, 540 insertions(+), 45 deletions(-)
| |
| | Oh gack.   And you've got stuff like "if numaq" in the sparc64
| | config files.
| |
| | You did have a version which instantiated a common $TOPDIR/kernel/Kconfig
| | and just included that in arch/<arch>/Kconfig.  Seems a better
| | approach to me.
|
| Yes, I like that better also.  This is a bit like design by committee.  :(
| I'm just trying to get it completed... and will update some more.

Linus, I withdraw that previous patch and will send the one that I
like and want, and will see how it's received/accepted.

-- 
~Randy

