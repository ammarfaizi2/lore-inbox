Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263933AbRFEJR3>; Tue, 5 Jun 2001 05:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263936AbRFEJRT>; Tue, 5 Jun 2001 05:17:19 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:59908 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S263933AbRFEJRL>;
	Tue, 5 Jun 2001 05:17:11 -0400
Date: Mon, 4 Jun 2001 12:41:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: Kip Macy <kmacy@netapp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for device to write device driver for
Message-ID: <20010604124139.C33@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.10.10106031613160.14668-100000@orbit-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.10.10106031613160.14668-100000@orbit-fe.eng.netapp.com>; from kmacy@netapp.com on Sun, Jun 03, 2001 at 04:23:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This may well be a question whose appropriate response is RTFM. 
> However, I did look first. 

What about 3com homefree camera [or is it homeconnect?]?
It is usb and unsupported; however
figuring it out should not be that hard. [It is usb, after all.]

Another device worth linux driver is lucent winmodem: it already has
userspace driver [see linmodems.org], and "telephony" version of
that driver would be nice.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

