Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268021AbRGZPLK>; Thu, 26 Jul 2001 11:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268086AbRGZPLA>; Thu, 26 Jul 2001 11:11:00 -0400
Received: from [195.6.125.97] ([195.6.125.97]:1548 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S268021AbRGZPKr>;
	Thu, 26 Jul 2001 11:10:47 -0400
Date: Thu, 26 Jul 2001 17:08:14 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: timer functions
Message-Id: <20010726170814.5f1aabe8.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.5.0pre1 (GTK+ 1.2.9; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I have a problem using timers. :-(

I want to change the function called by the timer :
	- the first call on the first function works fine
	- but the second call wich change the function being called
	  give me following error message : "bug: kernel timer added twice at c88cbdd7"
	  and the linux box hang totally

Is it possible to changed the called function ?

Any ideas ?

thanks

sebastien person
