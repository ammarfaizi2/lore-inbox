Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTD0F7e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 01:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTD0F7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 01:59:34 -0400
Received: from [12.47.58.68] ([12.47.58.68]:8831 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263398AbTD0F7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 01:59:33 -0400
Date: Sat, 26 Apr 2003 23:11:47 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] An generic subarchitecture for 2.5.68
Message-Id: <20030426231147.69efb07d.akpm@digeo.com>
In-Reply-To: <20030427012238.GA13997@averell>
References: <20030427012238.GA13997@averell>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2003 06:11:40.0301 (UTC) FILETIME=[DE1A23D0:01C30C83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> 
> This patch adds an generic x86 subarchitecture.

It causes a large number of compilation errors with the config at
http://www.zip.com.au/~akpm/linux/patches/stuff/config

Some Kconfig help would be nice...
