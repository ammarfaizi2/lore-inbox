Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbTCOWDX>; Sat, 15 Mar 2003 17:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbTCOWDX>; Sat, 15 Mar 2003 17:03:23 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30992 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261834AbTCOWDW>;
	Sat, 15 Mar 2003 17:03:22 -0500
Date: Sat, 15 Mar 2003 14:02:44 -0800
From: Greg KH <greg@kroah.com>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB issue in latest BK
Message-ID: <20030315220244.GC13446@kroah.com>
References: <3E72B573.1010007@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E72B573.1010007@cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 11:09:07PM -0600, David van Hoose wrote:
> In the last 3 bk snapshots my USB logitech cordless trackman has not 
> been detected at startup. Attached is my config. It worked in 2.5.64. 
> Something changed in the snapshots broke the driver.

Is there any messages in the kernel log about seeing any USB devices?

And if you boot without the mouse, and plug it in after booting, is it
seen then?

thanks,

greg k-h
