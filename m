Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbUAAWZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbUAAWZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:25:24 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:21487 "HELO
	smtp.vnoc.murphx.net") by vger.kernel.org with SMTP id S264594AbUAAWWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:22:41 -0500
Message-ID: <3FF49DDA.5030003@gadsdon.giointernet.co.uk>
Date: Thu, 01 Jan 2004 22:23:22 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031215
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1-mm1 - ieee1394 broken again?
References: <3FF2EFF3.6010001@gadsdon.giointernet.co.uk> <20031231115442.24df8501.akpm@osdl.org>
In-Reply-To: <20031231115442.24df8501.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  That fixed the problem.

Andrew Morton wrote:

> 
> 
> aargh, sorry.  You need to revert
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc1/2.6.1-rc1-mm1/broken-out/sysfs-add-vc-class.patch
> 
> This is the totally weird tty oops which Greg and I have been starting
> at bemusedly for a few days.
> 
> 
> 

-- 
..................................
Robert Gadsdon
..................................

