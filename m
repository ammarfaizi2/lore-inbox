Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbULMQjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbULMQjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULMQjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:39:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:29398 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261262AbULMQjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:39:05 -0500
Subject: Re: Is O_DIRECT + ext3 still broken on amd64?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Frank Denis <lkml@pureftpd.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041212220232.GA1427@c9x.org>
References: <20041212220232.GA1427@c9x.org>
Content-Type: text/plain
Organization: 
Message-Id: <1102954632.6708.144.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Dec 2004 08:17:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.. 

I have no idea what that post is taking about (may be I forgot,
2.6.7 is too old for me to remember).

AFAIK, there are no issues with O_DIRECT on ext3 on AMD64 now. 
We keep finding few issues with it as we keep tweaking it, but 
none of them are specific to AMD64.

Thanks,
Badari

On Sun, 2004-12-12 at 14:02, Frank Denis wrote:
>   According to this post:
>   
>   http://archives.neohapsis.com/archives/mysql/2004-q3/1535.html
>   
>   At least 2.6.7 kernels were bogus on AMD64 regarding O_DIRECT with files on
> an ext3 fs.
> 
>   Is this statement still true nowadays?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

