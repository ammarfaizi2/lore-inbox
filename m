Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbRFPTYr>; Sat, 16 Jun 2001 15:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264648AbRFPTYf>; Sat, 16 Jun 2001 15:24:35 -0400
Received: from [209.250.53.182] ([209.250.53.182]:2564 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S264647AbRFPTYc>; Sat, 16 Jun 2001 15:24:32 -0400
Date: Sat, 16 Jun 2001 13:32:43 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning in tdfxfb.c
Message-ID: <20010616133243.A1610@hapablap.dyn.dhs.org>
In-Reply-To: <20010616131237.A4378@hapablap.dyn.dhs.org> <E15BKmL-0008Q7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15BKmL-0008Q7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jun 16, 2001 at 07:26:37PM +0100
X-Uptime: 1:30pm  up 16 min,  1 user,  load average: 1.49, 1.70, 1.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.95.2; perhaps its fixed in 2.96/CVS?

On Sat, Jun 16, 2001 at 07:26:37PM +0100, Alan Cox wrote:
> > This patch is obviously correct.  It doesn't appear that tdfxfb has a
> > maintainer, so I'm sending this patch to the list.  Nothing
> 
> > earth-shattering, it just removes a warning during build.
> 
> Yep.. Im actually suprised gcc couldnt work that one out itself.

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
