Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263332AbTC0RRL>; Thu, 27 Mar 2003 12:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbTC0RQG>; Thu, 27 Mar 2003 12:16:06 -0500
Received: from [81.2.110.254] ([81.2.110.254]:53494 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263325AbTC0RQA>;
	Thu, 27 Mar 2003 12:16:00 -0500
Subject: Re: Kernel Itself Reports Bug, Continuous OOPS's, and Phantom NIC
	Card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Voigt <adam@cryptocomm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048784874.1874.18.camel@beowulf.cryptocomm.com>
References: <1048776183.1873.2.camel@beowulf.cryptocomm.com>
	 <1048784675.3228.7.camel@dhcp22.swansea.linux.org.uk>
	 <1048784874.1874.18.camel@beowulf.cryptocomm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048786126.3229.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 17:28:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 17:07, Adam Voigt wrote:
> Thanks for responding,
> 
> Yes, memtest passes with flying color's.

Next test is probably "noapm" as a boot option (so you dont
turn on any bios stuff that may be buggy) - also disable
bios power management and bios support for usb keyboard/mouse

