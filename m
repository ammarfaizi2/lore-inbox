Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbSJIRFr>; Wed, 9 Oct 2002 13:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261848AbSJIRFr>; Wed, 9 Oct 2002 13:05:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:27530 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261831AbSJIRFq>;
	Wed, 9 Oct 2002 13:05:46 -0400
Message-ID: <3DA4633B.26F0C33A@digeo.com>
Date: Wed, 09 Oct 2002 10:11:23 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Second round of ioctl cleanups
References: <20021009133337.Y18545@parcelfarce.linux.theplanet.co.uk> <20021009.053139.92842849.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2002 17:11:24.0086 (UTC) FILETIME=[E5426560:01C26FB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> If at some point we move all of the credits to some master log
> somewhere, that might be something we could do, but that's
> like 2.7.x I guess :-)

I had a bit of a head-scratch over this when tidying up the comment
block at the top of fs/buffer.c.  Precisely zero of those attributions
refer to code which exists any more!

Maybe we should do something like:

* Contributions by:
*     John Doe        (12/95)
*     ...
