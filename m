Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276734AbRJBWMj>; Tue, 2 Oct 2001 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276737AbRJBWMa>; Tue, 2 Oct 2001 18:12:30 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:22106 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S276734AbRJBWMQ>; Tue, 2 Oct 2001 18:12:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 doesn't boot
Date: Wed, 3 Oct 2001 00:12:43 +0200
X-Mailer: KMail [version 1.3]
Organization: TreeWater Society Berlin
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011002221243.9B240F4B@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan M. Brandl wrote:
>On Tue, Oct 02, 2001 at 01:11:13PM +0200, Stefan M. Brandl wrote:
>> Hi,
>> I'm unable to boot Kernel 2.4.10 (I also tried 2.4.10-ac3).
>> I get:
>> 
>> LILO Loading linux ...........
>> Uncompressing Linux... Ok, booting the kernel.
>> 

>Reply to my on mail.
>I was trying to boot an Athlon optimized kernel on a Pentium Box.
>Now it's optimized for Pentium and it boots.

This one caught me, too (building kernels for diskless ws).
Isn't it feasable to build in a check for the compiled architecture 
into the loader, and kernel panic instead of just dying...

>Stefan

Hans-Peter
