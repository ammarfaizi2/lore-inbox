Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313606AbSDPF6J>; Tue, 16 Apr 2002 01:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313609AbSDPF6I>; Tue, 16 Apr 2002 01:58:08 -0400
Received: from shell.unixbox.com ([207.211.45.65]:2571 "EHLO shell.unixbox.com")
	by vger.kernel.org with ESMTP id <S313606AbSDPF6H>;
	Tue, 16 Apr 2002 01:58:07 -0400
Date: Mon, 15 Apr 2002 23:08:36 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Peter Horton <pdh@berserk.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radeonfb ... again
In-Reply-To: <20020415221420.GA12057@berserk.demon.co.uk>
Message-ID: <Pine.BSF.4.44.0204152305300.66716-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, I'll review it this week and update the driver in the near future.
Although some of the fixes are already in my local version.


ani

On Mon, 15 Apr 2002, Peter Horton wrote:

> More "radeonfb" patch, still against 2.4.19-pre2.
>
> * Remove palette hacks for soft cursor by copying "revc" method.
> * Added "nostretch" option to disable stretching on DFPs.
> * Fast console switch (don't change PLL unless we have to).
> * Added module options.
> * Other fixes and cleanups.
>
> P.
>

