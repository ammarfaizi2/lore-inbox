Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129738AbRBUXSY>; Wed, 21 Feb 2001 18:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130290AbRBUXSR>; Wed, 21 Feb 2001 18:18:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:31639 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129738AbRBUXSA>;
	Wed, 21 Feb 2001 18:18:00 -0500
Date: Wed, 21 Feb 2001 18:17:33 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1ac20
In-Reply-To: <E14ViS0-0002yt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0102211815210.2261-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Alan Cox wrote:

> > The only candidates (it was a trivially small patch) seem to be:
> > the two additions:  dev->last_rx = jiffies ; I'll bet that at least
>
> Can you stick an if(dev!=NULL) in front of that and let me know if that
> fixes it - just to verify thats the problem spot

Compiling now, will reboot in the am (if it aint done soon) -
don't want it rebooting all night if this isn't it ;-}

-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

