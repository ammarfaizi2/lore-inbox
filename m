Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSERVEN>; Sat, 18 May 2002 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSERVEM>; Sat, 18 May 2002 17:04:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:42758 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S311871AbSERVEM>; Sat, 18 May 2002 17:04:12 -0400
Date: Sat, 18 May 2002 23:04:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Ivan Gyurdiev <ivangurdiev@linuxfreemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.16 Keyboard bug
Message-ID: <20020518210405.GA26480@louise.pinerecords.com>
In-Reply-To: <02051808513200.01086@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc4-ext3-0.0.7a SMP (up 2 days, 14:48)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...is still there.
> Sure, acpi=off "fixes" it, but that's not really a fix.
> Question...is this an acpi bug or a keyboard bug?

According to ACPI people this is an ACPI bug.
Updates are almost ready but still need some tweaking.

> Is there an existing patch to correct this that hasn't been merged into the 
> kernel yet?

In the meantime, you may want to give a shot to the patches at
http://sourceforge.net/projects/acpi/


T.

-- 
"when you do things right, people won't be sure you've done anything at all."
- god to bender
