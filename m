Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVATV76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVATV76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVATV6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:58:18 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:9706 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262081AbVATV5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:57:17 -0500
Message-ID: <41F02933.7040706@nortelnetworks.com>
Date: Thu, 20 Jan 2005 15:57:07 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120171544.GN12647@dualathlon.random> <20050120205204.GB11170@pclin040.win.tue.nl>
In-Reply-To: <20050120205204.GB11170@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

> But let me stress that I also consider the earlier situation
> unacceptable. It is really bad to lose a few weeks of computation.

Shouldn't the application be backing up intermediate results to disk 
periodically?  Power outages do occur, as do bus faults, electrical 
glitches, dead fans, etc.

Chris
