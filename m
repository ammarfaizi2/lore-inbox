Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSFPLEM>; Sun, 16 Jun 2002 07:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSFPLEL>; Sun, 16 Jun 2002 07:04:11 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:27320 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S316127AbSFPLEL>; Sun, 16 Jun 2002 07:04:11 -0400
Date: Sun, 16 Jun 2002 07:05:31 -0400
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020616110531.GA951@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At some point in the past, akpm wrote:
>>> Does this patch get the throughput back?

>> That makes all the difference to dbench.  

> How does it do against the prior 2.5 kernels?

dbench ext2 128    Average 
2.5.1-dj13           8.04 mb/sec 
2.5.2-dj6            8.59  
2.5.4-dj2            8.45  
2.5.16              11.06  
2.5.18-akpm         18.11  
2.5.18-wli          18.54  
2.5.19              18.60  
2.5.19-wli          18.54  
2.5.19-wli3         20.93  
2.5.20              12.89  
2.5.20-dj4          10.58  
2.5.21              12.67  
2.5.21-akpm         19.65

-- 
Randy Hron

