Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281470AbRKZFud>; Mon, 26 Nov 2001 00:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281471AbRKZFuX>; Mon, 26 Nov 2001 00:50:23 -0500
Received: from www.wen-online.de ([212.223.88.39]:28172 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S281470AbRKZFuM>;
	Mon, 26 Nov 2001 00:50:12 -0500
Date: Mon, 26 Nov 2001 07:49:55 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Chris Chabot <chabotc@reviewboard.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Severe Linux 2.4 kernel memory leakage
In-Reply-To: <1006699767.1178.0.camel@gandalf.chabotc.com>
Message-ID: <Pine.LNX.4.33.0111260740260.837-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Nov 2001, Chris Chabot wrote:

> Hi, I have a firewall / file server box which is displaying (severe)
> memory leakage, presumably by the kernel.
>
> The box has ran Redhat 7.1 and 7.2, with plain vanilla linux kernels
> 2.4.9 upto 2.4.15, in all situations the same problem appeared.

With 2.4.9 as well?  I have an IKD patch for 2.4.7 which I could
update to 2.4.9 fairly quickly if you'd like to try memleak on the
thing.  It might even go in fairly cleanly as is.

	-Mike

