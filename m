Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262566AbSJGS2X>; Mon, 7 Oct 2002 14:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262565AbSJGS2N>; Mon, 7 Oct 2002 14:28:13 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5892 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263153AbSJGSYV>;
	Mon, 7 Oct 2002 14:24:21 -0400
Date: Sun, 6 Oct 2002 23:06:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Tyner <jtyner@cs.ucr.edu>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       kraxel@bytesex.org
Subject: Re: Vicam/3com homeconnect usb camera driver
Message-ID: <20021006210629.GB387@elf.ucw.cz>
References: <Pine.LNX.4.30.0210032047510.15999-400000@hill.cs.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0210032047510.15999-400000@hill.cs.ucr.edu>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Attached is a driver for the 3Com HomeConnect USB Camera. The code is
> based somewhat on the vicam driver in the kernel (which crashes my
> computer hard) and also relies heavily on the information obtained by
> the guys doing the reverse engineering and kernel driver work at
> homeconnectusb.sourceforge.net. The fact that this driver works speaks
> very highly of them.
> 
> The driver gets the "It Works for Me" approval, but can definitely use
> some wider testing and review. Please test, review, and comment.
> 
> The code is for for 2.4.19, and I'll port it forward to 2.5 if it
> seems like it would be useful.

How is this different from 3comhc.c from sourceforge?

Anyway, this is *good stuff* (tm), as old vicam.c is not too
functional (to say at least). Basically anything is better than old
vicam.c
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
