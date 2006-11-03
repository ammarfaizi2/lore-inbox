Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753469AbWKCUOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbWKCUOM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbWKCUOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:14:12 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:9423 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1753469AbWKCUOL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:14:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [2.6.18] Suspend to ram and SATA
Date: Fri, 3 Nov 2006 21:12:14 +0100
User-Agent: KMail/1.9.1
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <454A61B0.9010306@gmail.com> <200611022243.02992.rjw@sisk.pl> <454B99C2.9010507@gmail.com>
In-Reply-To: <454B99C2.9010507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611032112.14406.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3 November 2006 20:34, Maciej Rutecki wrote:
> Rafael J. Wysocki napisa³(a):
> 
> > 
> > Can you please test 2.6.19-rc4 with CONFIG_DISABLE_CONSOLE_SUSPEND
> > unset?
> > 
> > Rafael
> > 
> > 
> I don't have this option:
> 
> rutek:/usr/src/linux-2.6.19-rc4# cat .config | grep SUSPEND
> CONFIG_SOFTWARE_SUSPEND=y
> CONFIG_SUSPEND_SMP=y
> CONFIG_USB_SUSPEND=y

So it is not set which is OK.

> but suspend to ram seems to work (I did't see any problem). Thanks for
> help :-)

You're welcome. :-)


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
