Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUGSU0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUGSU0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 16:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUGSU0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 16:26:20 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:18827 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265502AbUGSU0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 16:26:15 -0400
Message-ID: <40FC2E60.2030101@comcast.net>
Date: Mon, 19 Jul 2004 16:26:08 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: audio cd writing causes massive swap and crash
References: <40F9854D.2000408@comcast.net> <20040718071830.GA29753@suse.de> <40FBBAAE.5060405@comcast.net>
In-Reply-To: <40FBBAAE.5060405@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, I used hdparm to disable dma but writing still had the same 
result.  Just as the cd is nearly done swap is being used by 150+ MB and 
everything hangs.  I thought maybe it was the cd dma audio writing patch 
but doesn't look like that now.
