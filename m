Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311092AbSCWTwf>; Sat, 23 Mar 2002 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311148AbSCWTwY>; Sat, 23 Mar 2002 14:52:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:51925 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S311092AbSCWTwM>;
	Sat, 23 Mar 2002 14:52:12 -0500
Date: Sat, 23 Mar 2002 11:49:46 -0800 (PST)
From: Dave Zarzycki <dave@zarzycki.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: John Langford <jcl@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, <ahaas@neosoft.com>
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <3C9C8FA2.4090204@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0203231148570.1199-100000@yuna.zarzycki.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Martin Dalecki wrote:

> John Langford wrote:
> >>But before could you just tell the m5229_revision value
> >>on your system?
> > I'm not sure what you mean.  Certainly, lspci says:
> >>00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
> 
> That's it. Thank you.

To add another data-point, I've been seeing the same problem on a rev c4 
version of device.

davez

-- 
Dave Zarzycki
http://zarzycki.org/~dave/

