Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbTAFTP1>; Mon, 6 Jan 2003 14:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTAFTP1>; Mon, 6 Jan 2003 14:15:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10136 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267117AbTAFTP0>;
	Mon, 6 Jan 2003 14:15:26 -0500
Date: Mon, 6 Jan 2003 11:20:46 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Tom Rini <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
In-Reply-To: <Pine.LNX.4.44.0301061114460.13525-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0301061119400.15416-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Linus Torvalds wrote:

|
| On Mon, 6 Jan 2003, Tom Rini wrote:
| >
| > > Linus also told me that he's not crazy about this change.
| >
| > Maybe he would be, if it was cleaner than the current code in the end.
| > :)
|
| No, the reason I'm not crazy about it is that I simply _hate_ having too
| many user knobs to tweak. I don't like tweaking like that, it's just
| disturbing.
|
| I'd probably be happier if the current one didn't even _ask_ the user (or
| only asked the user if kernel debugging is enabled), and just silently
| defaulted to the normal values.

I'll be happy to move it there (later today)...

-- 
~Randy

