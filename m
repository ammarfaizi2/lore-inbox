Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbRG3T4O>; Mon, 30 Jul 2001 15:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbRG3T4E>; Mon, 30 Jul 2001 15:56:04 -0400
Received: from blacksun.leftmind.net ([204.225.88.62]:25604 "HELO
	blacksun.leftmind.net") by vger.kernel.org with SMTP
	id <S267713AbRG3Tz7>; Mon, 30 Jul 2001 15:55:59 -0400
Date: Mon, 30 Jul 2001 15:56:06 -0400
From: Anthony de Boer <adb@leftmind.net>
To: alonz@nolaviz.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
Message-ID: <20010730155606.A1655@leftmind.net>
In-Reply-To: <Pine.GSO.4.21.0107300137550.16140-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018101c11914$40bc3100$910201c0@zapper>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alon Ziv <alonz@nolaviz.org> wrote:
>I wonder...  May the initramfs be used also for loading modules ???
>Hmm... it will require a pico-insmod that can run in the limited initramfs
>environment, but I believe that's all !

I've built modutils against Felix von Leitner's dietlibc; that might
fit the bill.  See these two pages:

  http://www.fefe.de/dietlibc/
  http://www.leftmind.net/projects/misc/

-- 
Anthony de Boer, curator, Anthony's Home for Aged Computing Machinery
<adb@leftmind.net>
