Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSJaFaZ>; Thu, 31 Oct 2002 00:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSJaFaZ>; Thu, 31 Oct 2002 00:30:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:15059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264962AbSJaFaY>;
	Thu, 31 Oct 2002 00:30:24 -0500
Date: Wed, 30 Oct 2002 21:32:58 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Squashfs in the kernel?
In-Reply-To: <3DC0BE77.6060505@lougher.demon.co.uk>
Message-ID: <Pine.LNX.4.33L2.0210302130270.20212-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Phillip Lougher wrote:

| Hi,
|
| I'm a complete newbie here... What steps do I need to do to
| get something included in the kernel?

Generally, read linux/Documentation/Submitting*
and post the patch file to the appropriate mailing list(s)
for review.  After review and modifications, send it to
torvalds@transmeta.com and ask for it to be added to the
next version of the development kernel.

After it survives in the development kernel for awhile,
it might also be added to the stable kernel if it's not
a kernel interface change (e.g., a device driver or a
file system).

-- 
~Randy

