Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263859AbTCUUGZ>; Fri, 21 Mar 2003 15:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbTCUUF1>; Fri, 21 Mar 2003 15:05:27 -0500
Received: from pool-151-203-29-33.bos.east.verizon.net ([151.203.29.33]:8832
	"EHLO sbc") by vger.kernel.org with ESMTP id <S263966AbTCUUEF>;
	Fri, 21 Mar 2003 15:04:05 -0500
From: Seth Chandler <sethbc@gentoo.org>
Reply-To: sethbc@gentoo.org
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.65-mm3
Date: Fri, 21 Mar 2003 15:15:07 -0500
User-Agent: KMail/1.5.1
References: <20030320235821.1e4ff308.akpm@digeo.com>
In-Reply-To: <20030320235821.1e4ff308.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303211515.07134.sethbc@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew,

I'm getting some (sort of) random NFS Auth errors with -mm2 and -mm3.  
Sometimes the directories i export get exported read only, so i can't edit 
them on my nfs clients.  

When i'm running 2.5.65 from BK, the problem doesn't exist, its only when i 
switch to the -mm branch it manifests itself.  I was going to back out the 
nfs patches, and see if i could find the culprit....


thanks,

seth
On Friday 21 March 2003 02:58, Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm3/
>
> Will appear later at:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.65/2.5.65
>-mm3/
>

