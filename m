Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVBGQ5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVBGQ5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVBGQ5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:57:01 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:30877 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S261188AbVBGQ4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:56:55 -0500
Message-ID: <42079DCF.4070907@mnsu.edu>
Date: Mon, 07 Feb 2005 10:56:47 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Saaby <as@cohaesio.com>
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: linux-2.6.11-rc3: XFS internal error xfs_da_do_buf(1) at line
 2176 of file fs/xfs/xfs_da_btree.c.
References: <42078B74.2080306@mnsu.edu> <200502071713.03158.as@cohaesio.com>
In-Reply-To: <200502071713.03158.as@cohaesio.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Saaby wrote:

>Is this system running SMP og UP?
>
>On Monday 07 February 2005 16:38, Jeffrey E. Hundstad wrote:
>  
>
>>I'm sorry for this truncated report... but it's all I've got.  If you
>>need .config or system configuration, etc. let me know and I'll send'em
>>ASAP.  I don't believe this is hardware related; ide-smart shows all fine.
>>
>> From dmesg:
>>
>>xfs_da_do_buf: bno 8388608
>>dir: inode 117526252
>>Filesystem "hda4": XFS internal error xfs_da_do_buf(1) at line 2176 of
>>file fs/x
>>    
>>
>
>  
>
UP
