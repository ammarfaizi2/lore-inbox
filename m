Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVILPT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVILPT3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVILPT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:19:29 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:53348 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751371AbVILPT2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:19:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q7uYKBDB1j5mEoOsON+XnUQgY8c/USppwlBybYoAEonWolRH3h3CX9t+hS0ZpNHbfGVQOMsM3bdgPqeIVV/r5kH+VkO9yYoTUos0mWSbtrx+TaCjfK33VUxb5GEghVlLLj8SMRHDuJCrjvpqFRpfhuBmf6z+VDkbVoBmunZmQZs=
Message-ID: <4d8e3fd305091208191fbbe804@mail.gmail.com>
Date: Mon, 12 Sep 2005 17:19:21 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: paolo.ciarrocchi@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050912024350.60e89eb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050912024350.60e89eb1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm3/
> 
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm3.gz)
> 
> - perfctr was dropped.  Mikael has ceased development and recommends that
>  the focus be upon perfmon.  See
>  http://sourceforge.net/mailarchive/forum.php?thread_id=8102899&forum_id=2237
> 
> - There are several performance tuning patches here which need careful
>  attention and testing.  (Does anyone do performance testing any more?)

How about the tool announced months ago by Martin J. Bligh ?

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html

-- 
Paolo
