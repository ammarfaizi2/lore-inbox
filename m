Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbULRK6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbULRK6B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 05:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbULRK6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 05:58:01 -0500
Received: from postman.fhs-hagenberg.ac.at ([193.170.124.96]:59610 "EHLO
	postman.fhs-hagenberg.ac.at") by vger.kernel.org with ESMTP
	id S262092AbULRK57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 05:57:59 -0500
Date: Sat, 18 Dec 2004 11:56:07 +0100
From: Clemens Buchacher <drizzd@aon.at>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Documentation on top half and bottom halves
Message-ID: <20041218105607.GA19755@kzelldran.lan>
Mail-Followup-To: krishna <krishna.c@globaledgesoft.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41C3F9A2.3040700@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C3F9A2.3040700@globaledgesoft.com>
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 18 Dec 2004 10:57:56.0966 (UTC) FILETIME=[6E74F860:01C4E4F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 03:04:26PM +0530, krishna wrote:
>    Can any one tell me good Documentation on bottom halves beyond doubt.

Documentation on Tasklets:

- http://www.xml.com/ldd/chapter/book/ch09.html#t5
- kernel/softirq.c

Documentation on Workqueues:

- http://lwn.net/Articles/23634/
- kernel/workqueue.c


Clemens
