Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSHHTgJ>; Thu, 8 Aug 2002 15:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSHHTgI>; Thu, 8 Aug 2002 15:36:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47855 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317872AbSHHTgI>; Thu, 8 Aug 2002 15:36:08 -0400
Subject: Re: What about adding L1_CACHE_MASK and L1_CACHE_ALIGNED?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robin Holt <holt@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SGI.4.33.0208081416080.100441-100000@fsgi123.americas.sgi.com>
References: <Pine.SGI.4.33.0208081416080.100441-100000@fsgi123.americas.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 21:59:52 +0100
Message-Id: <1028840392.30103.90.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 20:29, Robin Holt wrote:
> 
> While doing some work with a hardware specific driver, I kept running
> across cases where the following mod to <linux/cache.h> would be helpful.
> What is the general opinion towards getting this accepted into 2.5?  How
> about 2.4.20?

Seems a sound idea. Get it in 2.5 and for 2.4 to follow should be simple

