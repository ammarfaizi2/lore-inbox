Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268027AbUHFClD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268027AbUHFClD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUHFClC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:41:02 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:53083 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268071AbUHFCiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:38:09 -0400
Subject: Re: Firewire hard drives
From: "Raf D'Halleweyn (list)" <list@noduck.net>
To: Erik Steffl <steffl@bigfoot.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <41129B77.5040504@bigfoot.com>
References: <200408051612.36445.caleb_gibbs@sbcglobal.net>
	 <16658.38447.591862.21787@gargle.gargle.HOWL>
	 <41129B77.5040504@bigfoot.com>
Content-Type: text/plain
Date: Thu, 05 Aug 2004 22:38:05 -0400
Message-Id: <1091759885.4861.5.camel@alto.dhalleweyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 13:41 -0700, Erik Steffl wrote:
> John Stoffel wrote:
> > Caleb> Has anyone had any luck getting there external firewire hard
> > Caleb> drive to mount?  my laptop is running suse9.0 and detects the
> > Caleb> firewire hub and works great with my usb devices but when I
> > Caleb> plug in the firewire hdd it boots the device but I can`t mount
> > Caleb> it.
> 
>    (sorry, missed the original post)
> 
>    I am using iPod as firewire disk, works fairly OK except of: sometime 
> it gets into state when system does not recognize the new SCSI disk (it 
> looks like SCSI disk) and nothing helps (unloading modules, 
> disconnecting the device etc.), didn't investigate enough to figure out 
> why (firewire drivers recognize the device but rescanning scsi doesn't 
> find the disk), only reboot helps (out of the options I tried). This is 
> not a bug report, just FYI, I don't have enough details to actually ask 
> for help...

When that happens, try to stop the iPod before you connect (i.e. press
play/pause for 5 seconds) or reboot the iPod (press Menu and play/pause
for 5 seconds).

At least, that works for me most of the times (not always).

Raf.

