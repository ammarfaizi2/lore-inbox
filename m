Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135247AbRDWOeC>; Mon, 23 Apr 2001 10:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135239AbRDWOdv>; Mon, 23 Apr 2001 10:33:51 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:11110 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S135225AbRDWOdn>; Mon, 23 Apr 2001 10:33:43 -0400
Date: Mon, 23 Apr 2001 17:33:30 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Subba Rao <subba9@home.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel: VM
Message-ID: <20010423173330.D3529@niksula.cs.hut.fi>
In-Reply-To: <20010423055237.B1997@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010423055237.B1997@home.com>; from subba9@home.com on Mon, Apr 23, 2001 at 05:52:37AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 05:52:37AM +0000, you [Subba Rao] claimed:
> Hi,
> 
> I have seen several of these messages in my kernel log this morning. The system

What kernel version.

> responded to ping but won't allow me to login. What is VM? 

Virtual memory subsystem in Linux kernel.

> What causes these errors and how can I prevent it from happening again?
 
A VM bug.

If you are running older 2.2, upgrade to 2.2.19. The bug was fixed by Andrea
Arcangeli around 2.2.19pre something.

Also, please search the mailing list archives before asking:

http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=try+free+pages+2.2+failed&q=b



-- v --

v@iki.fi
