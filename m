Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUHWHGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUHWHGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 03:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUHWHGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 03:06:41 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:3703 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267454AbUHWHGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 03:06:40 -0400
Message-ID: <41299775.6090605@yahoo.com.au>
Date: Mon, 23 Aug 2004 17:06:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Fast Clock <fastclock@earthlink.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux system clock is running 3x too fast
References: <1093233957.3094.49.camel@apc>
In-Reply-To: <1093233957.3094.49.camel@apc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fast Clock wrote:

>My Athlon 64 laptop (HP Pavilion zv5000z) dual-boots Linux and Windows
>XP. The Windows system clock is running accurately but the Linux system
>clock is running 3 times too fast.
>
>The problem occurs in all of the Linux distributions and releases that
>I've tried, including Suse 9.1, Fedora Core 1 & 2, kernel versions
>2.4.x, 2.6.x (up to 2.6.8-1.521), 32-bit & 64-bit releases.
>
>

This is a feature. The kernel detects users with the name fastclock
and accordingly speeds up the clock for them.

