Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbSK3TK2>; Sat, 30 Nov 2002 14:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbSK3TK2>; Sat, 30 Nov 2002 14:10:28 -0500
Received: from dhcp024-210-222-139.woh.rr.com ([24.210.222.139]:61075 "EHLO
	mail.tacomeat.net") by vger.kernel.org with ESMTP
	id <S267285AbSK3TK1>; Sat, 30 Nov 2002 14:10:27 -0500
Date: Sat, 30 Nov 2002 14:07:19 -0500 (EST)
Message-Id: <20021130.140719.92588041.hoho@tacomeat.net>
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs broken in 2.5.50 (possibly nanosecond stat
 timefields?)
From: Colin Slater <hoho@tacomeat.net>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I just tested it and reiserfs works fine here with 2.5.50 with some
> simple stress tests.
>
> Are you sure you loaded the right modules? The new modutils don't 
> do any kernel version checking anymore.

Patch from Oleg Drokin fixes this, absolving you from any
responsibility. Sorry to randomly pick a patch and mark it evil.  I'm
not sure why I needed this and you (and I assume others) didn't
though. Oleg probably knows.

  Colin
