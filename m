Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261843AbSJITNk>; Wed, 9 Oct 2002 15:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSJITNg>; Wed, 9 Oct 2002 15:13:36 -0400
Received: from blueberrysolutions.com ([195.165.170.195]:8597 "EHLO
	blueberrysolutions.com") by vger.kernel.org with ESMTP
	id <S261907AbSJITN1>; Wed, 9 Oct 2002 15:13:27 -0400
Date: Wed, 9 Oct 2002 22:19:02 +0300 (EEST)
From: Tony Glader <Tony.Glader@blueberrysolutions.com>
X-X-Sender: teg@blueberrysolutions.com
To: Chris Wright <chris@wirex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: capable()-function
In-Reply-To: <20021009120819.A25392@figure1.int.wirex.com>
Message-ID: <Pine.LNX.4.44.0210092217320.785-100000@blueberrysolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Chris Wright wrote:

> > In this case capable() call has been made from a kernel module. I think a
> The userspace task that called the ioctl() is the one to look at.

...

> > CapInh: 0000000000000000
> > CapPrm: 00000000fffffeff
> > CapEff: 00000000fffffeff
> 
> Ok, I don't think the capable() check is failing.

So though me too, but now we are getting to the point - capable() check 
fails! How that can be possible?

-- 
* Tony Glader 

