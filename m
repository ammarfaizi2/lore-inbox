Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbRFBViD>; Sat, 2 Jun 2001 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbRFBVhx>; Sat, 2 Jun 2001 17:37:53 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6404 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S261505AbRFBVhg>;
	Sat, 2 Jun 2001 17:37:36 -0400
Message-ID: <20010602112216.A682@bug.ucw.cz>
Date: Sat, 2 Jun 2001 11:22:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: david <david@apollos.ttu.ee>, linux-kernel@vger.kernel.org
Subject: Re: toshiba(freecom) USB cdrom kernel panic
In-Reply-To: <Pine.LNX.4.30.0105291154270.27600-400000@apollos.ttu.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0105291154270.27600-400000@apollos.ttu.ee>; from david on Tue, May 29, 2001 at 12:15:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> I have strange problems with my Toshiba(actually Freecom) USB cdrom cable.
> inserting the usb-storage takes some minutes, until it returns. Then
> mounting the cdrom works, but when i started copying from cd, a kernel
> panic occured. It happens every time, i try to copy something from cd.
> Kernel is 2.4.5. Hardware is Abit BE6-II / PIII 667. Decoded oops and
> dmesg output included, if more info is needed, please write directly to
> me, as i am not subscribed to this list. Thanks :)

Can you compile usb-storage into kernel to get more usefull oops?

Plus it would be nice to mail it linux-usb, where someone is more
likely to listen.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
