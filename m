Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSKTWKv>; Wed, 20 Nov 2002 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSKTWKv>; Wed, 20 Nov 2002 17:10:51 -0500
Received: from whfirewall.nwtel.ca ([199.85.228.1]:31106 "EHLO
	whfirewall.nwtel.ca") by vger.kernel.org with ESMTP
	id <S262808AbSKTWKr>; Wed, 20 Nov 2002 17:10:47 -0500
Message-Id: <5.1.1.6.0.20021120135311.0248d600@gnat.nwtel.ca>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 20 Nov 2002 14:17:47 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Richard Whittaker <rwhittak@gnat.nwtel.ca>
Subject: Re: Semaphore and Shared memory questions...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <sddb931a.041@nwtel.ca>
References: <5.1.1.6.0.20021120133929.02485ae8@gnat.nwtel.ca>
 <5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca>
 <5.1.1.6.0.20021120131444.02482858@gnat.nwtel.ca>
 <5.1.1.6.0.20021120133929.02485ae8@gnat.nwtel.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:16 PM 11/20/2002 -0800, Alan Cox wrote:
>On Wed, 2002-11-20 at 21:42, Richard Whittaker wrote:
> > At 10:04 PM 11/20/2002 +0000, Alan Cox wrote:
>
>Right first guess. Its mostly historical that it isnt 4 values.

What's the order of the values?...

I can take a wild stab that the first value is semmsl, or is it semmni, 
then the subsequent values?...

Are there plans to split them out into distinct values, or is that a 
massive rewrite?...

Thanks!
Richard.

---
Richard Whittaker,
System Manager,
NorthwesTel Inc.
Whitehorse, Yukon, Canada.

