Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbTC0S46>; Thu, 27 Mar 2003 13:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbTC0S45>; Thu, 27 Mar 2003 13:56:57 -0500
Received: from [81.2.110.254] ([81.2.110.254]:3575 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261303AbTC0S45>;
	Thu, 27 Mar 2003 13:56:57 -0500
Subject: Re: Kernel Itself Reports Bug, Continuous OOPS's, and Phantom NIC
	Card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Voigt <adam@cryptocomm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048787756.1873.25.camel@beowulf.cryptocomm.com>
References: <1048776183.1873.2.camel@beowulf.cryptocomm.com>
	 <1048784675.3228.7.camel@dhcp22.swansea.linux.org.uk>
	 <1048784874.1874.18.camel@beowulf.cryptocomm.com>
	 <1048786126.3229.18.camel@dhcp22.swansea.linux.org.uk>
	 <1048787756.1873.25.camel@beowulf.cryptocomm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048792179.3229.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 19:09:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 17:55, Adam Voigt wrote:
> Same thing, I ran a "find /" and when that didn't crash
> it, I ran lynx, and tried to download the kernel from
> kernel.org to try and make it die with all the compiling
> activity, but just quiting lynx crashed it. Also,
> I'm pretty sure this doesn't help, but the caps lock
> and scroll lock keys are blinking in a regular interval.

At this point I really suspect the hardware, assuming you
aren't loading junk weird modules and its not a misbuilt
kernel of somekind.

