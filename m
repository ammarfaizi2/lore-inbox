Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbSLLI0H>; Thu, 12 Dec 2002 03:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbSLLI0H>; Thu, 12 Dec 2002 03:26:07 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:26862 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267438AbSLLI0H>; Thu, 12 Dec 2002 03:26:07 -0500
Subject: Re: 2.4.20-ac2 and i810 drm
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <3457.210.8.93.34.1039665245.squirrel@www.csn.ul.ie>
References: <3457.210.8.93.34.1039665245.squirrel@www.csn.ul.ie>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 09:32:46 +0100
Message-Id: <1039681967.1450.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 04:54, Dave Airlie wrote:
> 
> I've been running 2.4.20-rc4 up to now with DRM enabled for my i810
> chipset and XFree86 4.2 from RH 7.3.
> 
> When I run my OpenGL application (internal app) under 2.4.20-ac2 with the
> same .config when I ctrl-c the application the machine hangs hard.
> 
> It is the only application running on the X server so the X server
> restarts when I exit the app.. under 2.4.20-rc4 this works fine...

I just got an updated source for the i810 DRM and will port it to -ac2;
lots of i810 bugfixes
