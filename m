Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292233AbSBBFxV>; Sat, 2 Feb 2002 00:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292234AbSBBFxL>; Sat, 2 Feb 2002 00:53:11 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:35340 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292233AbSBBFxC>;
	Sat, 2 Feb 2002 00:53:02 -0500
Date: Fri, 1 Feb 2002 21:51:16 -0800
From: Greg KH <greg@kroah.com>
To: Nathan <wfilardo@fuse.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Issues with 2.5.3-dj1
Message-ID: <20020202055115.GA11359@kroah.com>
In-Reply-To: <3C5B5EC0.40503@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5B5EC0.40503@fuse.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 05 Jan 2002 03:42:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 10:36:32PM -0500, Nathan wrote:
> System is a Sony VAIO R505JE, kernel 2.5.3-dj1 + preempt + acpi + acpi 
> pci irq routing.  Debian unstable, updated today.
> 
> 1: USB dies a very similar death in 2.5.3-dj1 as it did in 2.5.2-dj6 
> (OOPS below and in previous mail).  What else can I provide?

What were you doing with USB at the time?  Unloading the drivers?  What
USB host controller, and USB drivers were you using?

And the most important of all, does this also happen in 2.5.3?

thanks,

greg k-h
