Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268700AbTBZJcz>; Wed, 26 Feb 2003 04:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268701AbTBZJcz>; Wed, 26 Feb 2003 04:32:55 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:31236 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S268700AbTBZJcy>; Wed, 26 Feb 2003 04:32:54 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302260944.h1Q9idTZ000538@81-2-122-30.bradfords.org.uk>
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
To: coyote1@cytanet.com.cy (wyleus)
Date: Wed, 26 Feb 2003 09:44:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030226041214.71e1ddc7.coyote1@cytanet.com.cy> from "wyleus" at Feb 26, 2003 04:12:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My recently installed Mandrake 9.0 has been unstable since day one.
> The syslog is full of kernel BUG lines (see below), the crashes are
> frequent, and I don't know how to reproduce them - recognize no
> pattern to them.

[snip]

Since you have eliminated a lot of the hardware, I would check whether
the PSU is working correctly, if necessary by swapping in a spare one
for a day or two.

The easiest way to exercise the machine is probably to do kernel
compiles in a loop.  Memtest will exercise the memory, but not
particularly exercise the CPU.

John.
