Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSLJSXJ>; Tue, 10 Dec 2002 13:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSLJSXJ>; Tue, 10 Dec 2002 13:23:09 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:30219 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S263544AbSLJSXI>; Tue, 10 Dec 2002 13:23:08 -0500
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210182120.GD577@codemonkey.org.uk>
References: <1039522886.1041.17.camel@localhost.localdomain>
	<20021210131143.GA26361@suse.de>
	<1039538881.2025.2.camel@localhost.localdomain>
	<20021210140301.GC26361@suse.de>
	<1039547210.1071.26.camel@localhost.localdomain>
	<20021210172320.A4586@suse.de>
	<1039539977.14251.40.camel@irongate.swansea.linux.org.uk>
	<20021210170542.GB577@codemonkey.org.uk>
	<1039553986.1054.7.camel@localhost.localdomain> 
	<20021210182120.GD577@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 02:23:21 +0500
Message-Id: <1039555433.1054.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 23:21, Dave Jones wrote:
> On Wed, Dec 11, 2002 at 02:00:47AM +0500, Antonino Daplas wrote:
> I did something similar in my pending tree, but I just made it
> unconditional instead of littering lots of ifdefs.

That's great.  Thanks. 

Tony


