Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRJUEbo>; Sun, 21 Oct 2001 00:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275571AbRJUEbY>; Sun, 21 Oct 2001 00:31:24 -0400
Received: from zero.tech9.net ([209.61.188.187]:20499 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S275552AbRJUEbN>;
	Sun, 21 Oct 2001 00:31:13 -0400
Subject: Re: kswapd is CPU-hungry (kernel 2.4.2-2)
From: Robert Love <rml@tech9.net>
To: D Campbell <dcampbel_slo@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011021023402.77126.qmail@web20707.mail.yahoo.com>
In-Reply-To: <20011021023402.77126.qmail@web20707.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 21 Oct 2001 00:31:48 -0400
Message-Id: <1003638708.2258.49.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-20 at 22:34, D Campbell wrote:
> after searching the archives i'm still a bit concerned
> about the CPU usage of kswapd on a machine with lots of memory.

a lot of VM work has been done, in particular to solve your problem. 
Two solutions have emerged, one in Alan's tree and one in Linus's.

I suggest you try one (or -- even better -- both).  I would be surprised
if your problem wasn't fixed.  The newest release in Alan's tree is
2.4.12-ac3 and it is running great here.  Linus has released a
2.4.13-pre5.

	Robert Love

