Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266382AbRGGOq7>; Sat, 7 Jul 2001 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266352AbRGGOqu>; Sat, 7 Jul 2001 10:46:50 -0400
Received: from ns0.ogilvy.net ([193.41.71.28]:12809 "HELO ogilvy.net")
	by vger.kernel.org with SMTP id <S266345AbRGGOqp>;
	Sat, 7 Jul 2001 10:46:45 -0400
Message-ID: <3B4720B3.7C16F6AA@ogilvy.net>
Date: Sat, 07 Jul 2001 16:46:11 +0200
From: Francois Scala <fscala@ogilvy.net>
Organization: Ogilvy Interactive
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: crazy timer on dual pentium-mmx (2.4.5 and 2.4.6)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,

I have a serious problem since 2.4.5 kernel, the timer go crazy (about
10 time normal speed)
I can't login because the 60 secondes timeout get only a few second in
real life.
Same thing about harddrive timeout error.

The motherboard is a dual pentium-mmx 200

http://www.asus.com/products/motherboard/pentium/p65up5-p55t2d/p65up5-p55t2d-spec.html
http://www.asus.com/Products/Motherboard/Pentiumpro/P65up5-p6nd/c-p55t2d.html

kernel is compiled on the computer with kernel 2.4.4 and following
tools:

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
