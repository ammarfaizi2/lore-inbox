Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSFIOjM>; Sun, 9 Jun 2002 10:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317611AbSFIOjL>; Sun, 9 Jun 2002 10:39:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62733 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317616AbSFIOjF>; Sun, 9 Jun 2002 10:39:05 -0400
Message-ID: <3D035ACA.2070309@evision-ventures.com>
Date: Sun, 09 Jun 2002 15:40:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
CC: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: comments on adding slist.h
In-Reply-To: <Pine.GSO.4.05.10206091405450.16324-100000@mausmaki.cosy.sbg.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas 'Dent' Mirlacher wrote:
> since we've already list.h, what about adding slist.h for
> single linked lists?
> 
> single linked list are often used within the kernel,
> specifically slist_for_each() could be useful, since we can use
> prefetch() there.  (slist_for_each could be used 42 times alone net/core)
> 
> any comments, (like, single linked lists are so trivial, there is no
> need for a header file. or, the programmer has to take care of using
> prefetch() when traversing single linked lists ...) are welcome.
> 
> thanks,
> 	tm


Just do it plese. It has been long overdue.

