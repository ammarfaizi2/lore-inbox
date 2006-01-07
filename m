Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWAGOus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWAGOus (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbWAGOur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:50:47 -0500
Received: from [202.67.154.148] ([202.67.154.148]:40093 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1030471AbWAGOuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:50:46 -0500
Message-ID: <43BFD54A.2080805@ns666.com>
Date: Sat, 07 Jan 2006 15:50:50 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Night Owl 3.12V
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in as_insert_request at drivers/block/as-iosched.c:1519
References: <43BFC3FF.5080908@ns666.com> <20060107143447.GF3389@suse.de>
In-Reply-To: <20060107143447.GF3389@suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Jan 07 2006, Mark v Wolher wrote:
> 
>>Hiya all,
>>
>>I was just playing a cd as usual and i noticed suddenly the errors
>>below, they repeated like 8 times.
>>
>>kernel: 2.6.14.5
> 
> 
> Should be fixed in newer 2.6.14.x, and in 2.6.15.
> 

Looks like it isn't :( , well in 2.6.14.5
