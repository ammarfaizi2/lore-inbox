Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266544AbRGJPZl>; Tue, 10 Jul 2001 11:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266579AbRGJPZc>; Tue, 10 Jul 2001 11:25:32 -0400
Received: from ns1.ecpi.com ([216.141.24.3]:53004 "EHLO ecpi.com")
	by vger.kernel.org with ESMTP id <S266544AbRGJPZ0>;
	Tue, 10 Jul 2001 11:25:26 -0400
Date: Tue, 10 Jul 2001 10:29:35 -0500
From: Joe Barr <warthawg@ecpi.com>
To: linux-kernel@vger.kernel.org
Subject: Bogomips Replacement
Message-Id: <20010710102935.5b5d6cfb.warthawg@ecpi.com>
Organization: Linux Liberation Army
X-Mailer: Sylpheed version 0.5.0pre2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi, everyone

I've just finished reading "Teach Yourself Linux Kernel Hacking In 15 Minutes" and feel like I'm ready to jump into the fray and start making contributions.  So, where to start.  I feel like that lady on TV, looking for the weakest link.

What I want to do is rip out the bogomips code and replace it with something completely different.  Does anyone know who currently maintains it?  As I recall from the Geek Bowl earlier this year in NYC, nobody really knows what that bogomips stuff does anyway. 

My idea is to add an active FUD filter to the kernel by sampling selected stories on LinuxToday and then providing a realtime bogosity rating.  Drawing on my extensive cultural training, I've decided to borrow an idea from the movie Spinal Tap.  Instead of having the meter show a bogosity reading between zero and ten, it will span from zero to MS.

Oh, one more question before I begin.  It is OK to do kernel patches in Visual RPG, isn't it?

See ya,
Joe Barr


-- 
#====================================================#
# Joe Barr                         warthawg@ecpi.com #
#====================================================#
