Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWAUSKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWAUSKX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 13:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWAUSKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 13:10:23 -0500
Received: from [212.76.85.126] ([212.76.85.126]:27661 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932223AbWAUSKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 13:10:22 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] VM: I have a dream...
Date: Sat, 21 Jan 2006 21:08:41 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601212108.41269.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A long time ago, when i was a kid, I had dream. It went like this:

I am waking up in the twenty-first century and start my computer.
After completing the boot sequence, I start top to find that my memory is 
equal to total disk-capacity.  What's more, there is no more swap.
Apps are executed inplace, as if already loaded.
Physical RAM is used to cache slower storage RAM, much the same as the CPU 
cache RAM caches slower physical RAM.

When I woke up, I was really looking forward for the new century.

Sadly, the current way of dealing with memory can at best only be described 
as schizophrenic.  Again the reason being, that we are still running in the 
last-century mode.

Wouldn't it be nice to take advantage of todays 64bit archs and TB drives, 
and run a more modern way of life w/o this memory/storage split personality?

All comments, other than "dream on", are most welcome!

Thanks!

--
Al

