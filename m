Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267955AbUHEUmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267955AbUHEUmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUHEUmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:42:49 -0400
Received: from mrout2.yahoo.com ([216.145.54.172]:25780 "EHLO mrout2.yahoo.com")
	by vger.kernel.org with ESMTP id S267955AbUHEUmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:42:17 -0400
Message-ID: <41129B77.5040504@bigfoot.com>
Date: Thu, 05 Aug 2004 13:41:27 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.5) Gecko/20031111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: caleb_gibbs@sbcglobal.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Firewire hard drives
References: <200408051612.36445.caleb_gibbs@sbcglobal.net> <16658.38447.591862.21787@gargle.gargle.HOWL>
In-Reply-To: <16658.38447.591862.21787@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:
> Caleb> Has anyone had any luck getting there external firewire hard
> Caleb> drive to mount?  my laptop is running suse9.0 and detects the
> Caleb> firewire hub and works great with my usb devices but when I
> Caleb> plug in the firewire hdd it boots the device but I can`t mount
> Caleb> it.

   (sorry, missed the original post)

   I am using iPod as firewire disk, works fairly OK except of: sometime 
it gets into state when system does not recognize the new SCSI disk (it 
looks like SCSI disk) and nothing helps (unloading modules, 
disconnecting the device etc.), didn't investigate enough to figure out 
why (firewire drivers recognize the device but rescanning scsi doesn't 
find the disk), only reboot helps (out of the options I tried). This is 
not a bug report, just FYI, I don't have enough details to actually ask 
for help...

	erik

