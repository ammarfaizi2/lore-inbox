Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUKNUDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUKNUDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUKNUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:03:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4822 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261347AbUKNUCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:02:36 -0500
Message-ID: <4197B9DB.6060408@us.ibm.com>
Date: Sun, 14 Nov 2004 12:02:35 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2 DIO failures
References: <419553B3.7000802@us.ibm.com> <20041112163647.73c0ebd8.akpm@osdl.org>
In-Reply-To: <20041112163647.73c0ebd8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
>>I see LTP DIO test failures on 2.6.10-rc1-mm2 while doing
>>direct-IO write to filesystem files.
> 
> 
> Fixed in -mm5.  See
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/readpage-vs-invalidate-fix.patch
> 
> 

Verified and work fine now.

Thanks,
Badari
