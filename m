Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281197AbRKUBwN>; Tue, 20 Nov 2001 20:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281429AbRKUBwD>; Tue, 20 Nov 2001 20:52:03 -0500
Received: from freeside.toyota.com ([63.87.74.7]:30980 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S281197AbRKUBvz>; Tue, 20 Nov 2001 20:51:55 -0500
Message-ID: <3BFB08B2.3AE5BF60@lexus.com>
Date: Tue, 20 Nov 2001 17:51:46 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mroth@calpoly.edu
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spawning kernel threads from other kernel threads(?)
In-Reply-To: <H00006040937765d.1006306811.davinci.artisan.calpoly.edu@MHS>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mroth@calpoly.edu wrote:

> Question:
>         Can you spawn a kernel thread from another kernel thread? I want to
> have one manager ?entity? which will dynamically create kernel threads as
> needed. Right now, when I try to spawn another thread from the manager ?entity?
> [as of today, still a kernel thread] it will crash. Is this legal? If not, what
> is the alternative?
>
> kernel_thread()
> Kernel Version 2.4.3

2.4.3 is awfully stale for starters -

and BTW what is an "?entity?" ?

cu

jjs

