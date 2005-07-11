Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVGKPQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVGKPQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVGKPOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:14:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37027 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261966AbVGKPNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:13:41 -0400
Date: Mon, 11 Jul 2005 17:13:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paul Sladen <thinkpad@paul.sladen.org>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [ltp] IBM HDAPS Someone interested? (Userspace accelerometer viewer)
Message-ID: <20050711151330.GB2001@elf.ucw.cz>
References: <42C7A3B2.4090502@linuxwireless.org> <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > PLEASE read the following article, it has the data of a guy that made a 
> > driver in IBM for Linux and he described the driver he made.
> > http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
> 
> Yesterday evening, I used my time here at Debconf5 constructively!  ;-)
> 
>   http://www.paul.sladen.org/thinkpad-r31/aps/accelerometer-viewer.jpg    (43kB)
>   http://www.paul.sladen.org/thinkpad-r31/aps/accelerometer-lid-shut.jpg  (27kB)
> 
> The sensor gives us two 10-bit AD values (corresponding to 0..1 volts on the
> ADI chip), temperature (Celsius) and three status bits indicating:
> 
>   * lid open/closed
>   * keyboard activity
>   * nipple movement

Oh, very nice pictures indeed...  What is the current interface
between userspace and kernel parts?
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
