Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264969AbSLESa7>; Thu, 5 Dec 2002 13:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSLESa6>; Thu, 5 Dec 2002 13:30:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:7879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264969AbSLESa6>;
	Thu, 5 Dec 2002 13:30:58 -0500
Date: Thu, 5 Dec 2002 10:35:14 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: george anzinger <george@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ] POSIX clocks & timers take 15 (NOT HIGH RES)
In-Reply-To: <Pine.LNX.4.44.0212050904390.27298-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0212051033170.17403-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, Linus Torvalds wrote:

| Ok, finally starting to look at merging this, however:

I'm not too fond of changing NR_syscalls to the computed nr_syscalls,
or rather, not in this same patch.
IOW, it should be a separate patch IMO.

-- 
~Randy

