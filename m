Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSJLXLA>; Sat, 12 Oct 2002 19:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJLXLA>; Sat, 12 Oct 2002 19:11:00 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:23558 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S261370AbSJLXK7>; Sat, 12 Oct 2002 19:10:59 -0400
Message-ID: <3DA8AE5F.8F4E72DE@compuserve.com>
Date: Sat, 12 Oct 2002 19:21:03 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Hello all,
 	  I don't believe has been reported yet. While 'make bzImage' for 
 	2.5.41-ac2 , I receieved the following error:
 	net/built-in.o: In function `llc_init':
 	net/built-in.o(.text.init+Re: 2.5.41-ac2 : llc_proc_exit undefined
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello all,
>   I don't believe has been reported yet. While 'make bzImage' for 
> 2.5.41-ac2 , I receieved the following error:
> 
> net/built-in.o: In function `llc_init':
> net/built-in.o(.text.init+0x8a1): undefined reference to `llc_proc_exit'
> make: *** [.tmp_vmlinux1] Error 1
> 

Did you resolve this?  I see this also with 2.5.42.

I'm using:
gcc 3.2
binutils 2.12.90.0.15

-- 
Kevin
