Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSAIVL0>; Wed, 9 Jan 2002 16:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSAIVLR>; Wed, 9 Jan 2002 16:11:17 -0500
Received: from air-1.osdl.org ([65.201.151.5]:38153 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S287764AbSAIVLE>;
	Wed, 9 Jan 2002 16:11:04 -0500
Date: Wed, 9 Jan 2002 13:09:35 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: peter <arevill@bigpond.net.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Steps to open a file/handled by kernel?
In-Reply-To: <3C3CAEDD.8040707@bigpond.net.au>
Message-ID: <Pine.LNX.4.33L2.0201091308570.9139-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, peter wrote:

| CC: all replies to: arevill@bigpond.net.au
| Hi guys, im in discussion with one of my compsci mates to start an
| intresting little project, its not concrete yet, not at all, i really
| need to get a good grasp of what im going to have to code before i
| decide to jump in or not, ill give you a quick run down
|
| Basically we want to make a sort of.. auto compression/uncompression of
| files as there accessed/not accessed, basically to save a hell of alot
| of space, but before we even BEGIN to do it, i really need to understand
| the calls and the "arguments" and the stages the kernel/userspace (if it
| is invovled (if userspace is even the right word!) takes to read from a
| file (and write to it while we are at it)
|
| any information people feel is relevant or any sort of url u can point
| me to or just a little guide of waht happens would be appreciiated,
| please CC: all msgs to arevill@bigpond.net.au

maybe this will help:
  http://www.win.tue.nl/~aeb/linux/vfs/trail.html#toc3

-- 
~Randy

