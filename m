Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281988AbRKZSGB>; Mon, 26 Nov 2001 13:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281987AbRKZSFw>; Mon, 26 Nov 2001 13:05:52 -0500
Received: from postal2.lbl.gov ([131.243.248.26]:41653 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S281961AbRKZSFp>;
	Mon, 26 Nov 2001 13:05:45 -0500
Message-ID: <3C028210.719F900C@lbl.gov>
Date: Mon, 26 Nov 2001 09:55:28 -0800
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-final drivers/net/bonding.c includes user space headers
In-Reply-To: <18133.1006497103@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> 2.4.15-final/drivers/net/bonding.c:188: #include <limits.h>
> 
> Kernel code must not include use space headers.  I thought this had
> been fixed.  It will not compile in 2.5.
> 

I should probably also point out that I'm not the maintainer/creator of
that version that did this too..

The Lab hasn't said yet from the DOE's point of view it's ok to work on
GPL to me, as part of my job..

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
