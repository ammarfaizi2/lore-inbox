Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754174AbWKMHZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbWKMHZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 02:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbWKMHZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 02:25:00 -0500
Received: from ref.nmedia.net ([66.39.177.2]:24654 "EHLO ref.nmedia.net")
	by vger.kernel.org with ESMTP id S1754174AbWKMHZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 02:25:00 -0500
Date: Sun, 12 Nov 2006 23:24:58 -0800 (PST)
From: Shaun Q <shaun@c-think.com>
X-X-Sender: shaun@ref.nmedia.net
To: linux-kernel@vger.kernel.org
Subject: Dual cores on Core2Duo not detected?
Message-ID: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there everyone --

I'm trying to build a custom kernel for using both cores of my new 
Core2Duo E6600 processor...

I thought this was simply a matter of enabling the SMP support in the 
kernel .config and recompiling, but when the kernel comes back up, still 
only one core is detected.

With the default vanilla text-based SuSE 10.1 install, it does find both 
cores...

Anyone have any pointers for me on what I might be missing?

Thanks!
Shaun
