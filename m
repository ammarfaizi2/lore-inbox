Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132654AbRC2DV2>; Wed, 28 Mar 2001 22:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132655AbRC2DVR>; Wed, 28 Mar 2001 22:21:17 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:32787 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132654AbRC2DVN>; Wed, 28 Mar 2001 22:21:13 -0500
Message-Id: <200103290320.f2T3KNs02696@aslan.scsiguy.com>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux-2.4.2-ac27 - read on /proc/bus/pci/devices never finishes after rmmod aic7xxx 
In-Reply-To: Your message of "Wed, 28 Mar 2001 20:16:38 CST."
             <3AC29B06.16A7C987@mnsu.edu> 
Date: Wed, 28 Mar 2001 20:20:23 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>I'm using Linux-2.4.2-ac27 SMP compiled with gcc version 2.95.2 20000220
>(Debian GNU/Linux).

What version of the aic7xxx driver is embedded in 2.4.2-ac27?  This
particular issue was fixed just after 6.1.5 was released.

--
Justin
