Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTBYBUK>; Mon, 24 Feb 2003 20:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbTBYBSi>; Mon, 24 Feb 2003 20:18:38 -0500
Received: from dp.samba.org ([66.70.73.150]:5339 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265114AbTBYBSK>;
	Mon, 24 Feb 2003 20:18:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       andrew.grover@intel.com
Subject: Re: enable mem= to mark memory as acpi-reserved 
In-reply-to: Your message of "Thu, 20 Feb 2003 22:56:38 BST."
             <20030220215638.GA18387@elf.ucw.cz> 
Date: Tue, 25 Feb 2003 11:02:24 +1100
Message-Id: <20030225012823.7A5572C4DD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030220215638.GA18387@elf.ucw.cz> you write:
> Hi!
> 
> This enables user to mark memory acpi-reserved; this is needed to get
> acpi working on PaceBlade tablet (it has broken e820 tables). Second
> diff makes printk output better aligned so it is possible to compare
> RAM maps by eyes. Please apply,

Second is trivial, first isn't.  Suggest send to Andrew Grover.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
