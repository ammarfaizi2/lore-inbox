Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271818AbRHRMlP>; Sat, 18 Aug 2001 08:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271819AbRHRMlF>; Sat, 18 Aug 2001 08:41:05 -0400
Received: from mail.mbi-berlin.de ([194.95.11.12]:59082 "EHLO
	mail.mbi-berlin.de") by vger.kernel.org with ESMTP
	id <S271818AbRHRMkx>; Sat, 18 Aug 2001 08:40:53 -0400
Message-ID: <3B7E6281.DDD093B7@informatik.hu-berlin.de>
Date: Sat, 18 Aug 2001 14:41:37 +0200
From: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Feng Xian <fxian@fxian.jukie.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: is there a way to let kernel to skip one region of physical memory?
In-Reply-To: <Pine.LNX.4.33.0108172058160.5581-100000@tiger>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Xian wrote:
> 
> Hi, all,
> 
> I have a question. say I have 128M physical memory, but for some reason, I
> don't want the kernel to use a little part of that memory, e.g. physical
> address from 4M to 5M. is there a way to let the kernel to do something
> like this? thanks in advance.

I think the badram kernel patches do just that.  See
http://rick.vanrein.org/linux/badram/.

Cheers,
Viktor
-- 
Viktor Rosenfeld
WWW: http://www.informatik.hu-berlin.de/~rosenfel/

