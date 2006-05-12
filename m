Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWELN4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWELN4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWELN4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:56:08 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42948 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932083AbWELN4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:56:07 -0400
Message-ID: <446493F2.3000701@us.ibm.com>
Date: Fri, 12 May 2006 06:56:02 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, hch@lst.de, bcrl@kvack.org,
       cel@citi.umich.edu
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>	<1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>	<20060512030309.3a94bea8.akpm@osdl.org> <20060512030855.65651bb5.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Andrew Morton <akpm@osdl.org> wrote:
>
>>Please send fix.
>>
>
>On second thoughts, I'll drop them all.  Too many fixups, this code needs
>more work.
>
>Please ensure that the next version passes allmodconfig without adding any
>new warnings on both 32-bit and 64-bit compilers, thanks.
>
Will do. I have been building and testing on 64-bit machines (amd64, ppc64).

Thanks,
Badari

>


