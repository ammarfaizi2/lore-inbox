Return-Path: <linux-kernel-owner+w=401wt.eu-S965134AbXAJV4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbXAJV4N (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbXAJV4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:56:13 -0500
Received: from mail.tmr.com ([64.65.253.246]:40520 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965134AbXAJV4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:56:12 -0500
Message-ID: <45A5614D.4050204@tmr.com>
Date: Wed, 10 Jan 2007 16:57:33 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Ram <vshrirama@gmail.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: compiling linux kernels with gcc 4.x
References: <8bf247760701082258w57f9edfau6e0ca0dec649a107@mail.gmail.com>
In-Reply-To: <8bf247760701082258w57f9edfau6e0ca0dec649a107@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> Hi,
>   Im unable to compile linux 2.6.14 with gcc 4.x, but new versions of
> kernel i can compile.
>   with gcc 4.x.
> 
>   It gives errors - that seem to disappear when compiled with gcc - 3.4.x
> 
> 
>  I really dont understand why?.

There were changes to the kernel to get rid of 4.x problems, that at 
least tells you why.
> 
> 
> Is there anyway we can compile lower versions of linux using gcc 4.x.
> 
> Im using a arm-linux-gcc.

I can't even give you a guess on that, other than patching your kernel 
with individual patches used to avoid compilation problems.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
