Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263339AbTC0Rol>; Thu, 27 Mar 2003 12:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263340AbTC0Rol>; Thu, 27 Mar 2003 12:44:41 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:52171 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S263339AbTC0Rok>;
	Thu, 27 Mar 2003 12:44:40 -0500
Subject: Re: Kernel Itself Reports Bug, Continuous OOPS's, and Phantom NIC
	Card
From: Adam Voigt <adam@cryptocomm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048786126.3229.18.camel@dhcp22.swansea.linux.org.uk>
References: <1048776183.1873.2.camel@beowulf.cryptocomm.com>
	<1048784675.3228.7.camel@dhcp22.swansea.linux.org.uk>
	<1048784874.1874.18.camel@beowulf.cryptocomm.com> 
	<1048786126.3229.18.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Mar 2003 12:55:56 -0500
Message-Id: <1048787756.1873.25.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 27 Mar 2003 17:55:55.0299 (UTC) FILETIME=[1D3CE730:01C2F48A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same thing, I ran a "find /" and when that didn't crash
it, I ran lynx, and tried to download the kernel from
kernel.org to try and make it die with all the compiling
activity, but just quiting lynx crashed it. Also,
I'm pretty sure this doesn't help, but the caps lock
and scroll lock keys are blinking in a regular interval.

On Thu, 2003-03-27 at 12:28, Alan Cox wrote:
> Next test is probably "noapm" as a boot option (so you dont
> turn on any bios stuff that may be buggy) - also disable
> bios power management and bios support for usb keyboard/mouse

-- 
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

