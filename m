Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311612AbSCNSCR>; Thu, 14 Mar 2002 13:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311635AbSCNSCI>; Thu, 14 Mar 2002 13:02:08 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:39181 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311612AbSCNSB5>; Thu, 14 Mar 2002 13:01:57 -0500
Message-ID: <3C90E53B.2A49A6A6@zip.com.au>
Date: Thu, 14 Mar 2002 10:00:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre3aa2
In-Reply-To: <20020314032801.C1273@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> Only in 2.4.19pre3aa2: 10_vm-32
> 
>         Fixed ext3 deadlock and "theorical" mainline SMP race for
>         some arch.
> 

That works fine.  ext3 is happy again.

-
