Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293678AbSCFQyc>; Wed, 6 Mar 2002 11:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293682AbSCFQyN>; Wed, 6 Mar 2002 11:54:13 -0500
Received: from [63.170.174.196] ([63.170.174.196]:64260 "EHLO
	localhost.seg.inf.cu") by vger.kernel.org with ESMTP
	id <S293678AbSCFQyL>; Wed, 6 Mar 2002 11:54:11 -0500
Message-ID: <3C8648B4.4090104@seg.inf.cu>
Date: Wed, 06 Mar 2002 11:49:56 -0500
From: israel fdez <israel@seg.inf.cu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@debian.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question??
In-Reply-To: <fa.b7d71pv.8n891g@ifi.uio.no> <3C864815.1000009@debian.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I agree, but I guess my question was not the correct one  :-[ . I 
need to know the full path to a module is going to be loaded from the 
sys_create_module system call, for example.

reg@rds
Israel

Giacomo Catenazzi wrote:

> israel fdez wrote:
>
>> Hi all, how can I get the full path of a module that is intended to 
>> be insmod'ed into the kernel
>
>
>
> insmod /fullpath/module.o
>
> RTFM
>
>     giacomo
>
>
>
> .
>


