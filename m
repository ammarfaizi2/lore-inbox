Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSLIFn3>; Mon, 9 Dec 2002 00:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSLIFn3>; Mon, 9 Dec 2002 00:43:29 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:52161 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262877AbSLIFn2>; Mon, 9 Dec 2002 00:43:28 -0500
Date: Sun, 8 Dec 2002 21:56:01 -0800 (PST)
From: Michal Zalewski <lcamtuf@dione.ids.pl>
X-X-Sender: lcamtuf@nimue.bos.bindview.com
To: linux-kernel@vger.kernel.org
Subject: mmap() on /proc/pid/mem
Message-ID: <Pine.LNX.4.42.0212082147050.726-100000@nimue.bos.bindview.com>
X-Nmymbofr: Nir Orb Buk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I'm trying to determine what was the reason for mmap() on /proc/pid/mem
being removed somewhere down the road between 2.2 and 2.4. I tried to do
my homework, but Google and 2.4 changelogs do not give too many clues. I
found several other posts on this and other groups from people complaining
it's gone, but that's all...

So - where is it? Is it coming back in the future? The feature was pretty
useful for debugging and some other purposes.

Thanks,
-- 
------------------------- bash$ :(){ :|:&};: --
 Michal Zalewski * [http://lcamtuf.coredump.cx]
    Did you know that clones never use mirrors?
--------------------------- 2002-12-08 21:47 --

