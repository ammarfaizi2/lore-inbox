Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbREQL0J>; Thu, 17 May 2001 07:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbREQLZ7>; Thu, 17 May 2001 07:25:59 -0400
Received: from fwso.framfab.dk ([195.219.76.189]:55248 "HELO fwso.framfab.dk")
	by vger.kernel.org with SMTP id <S261397AbREQLZx>;
	Thu, 17 May 2001 07:25:53 -0400
Message-ID: <3B03B5C7.5040107@fugmann.dhs.org>
Date: Thu, 17 May 2001 13:28:07 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
Organization: Framfab
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Exporting symbols from a module.
In-Reply-To: <200105152245.f4FMjnwN021983@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas.

I now see what you mean, and I will give it a try.

But actually I'm not compiling it under the linux kernel tree, and  I 
really would like a way to export symbols, while compiling outside the 
kernel tree. How would I accomplish that?

Regards
Anders Fugmann


Andreas Dilger wrote:

> Anders Fugmann writes:
> 
>>I'm not sure where to put this in my Makefile.
>>(tried, but it did not help)
>>Could you please send an example.
>>
> 
> See fs/Makefile or fs/msdos/Makefile for examples.  I assume you are
> building your module under the kernel tree?
> 
> Cheers, Andreas
> 



