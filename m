Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVFTVKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVFTVKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFTVHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:07:19 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:47752 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261373AbVFTUxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:53:39 -0400
Date: Mon, 20 Jun 2005 22:53:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Message-ID: <20050620205348.GA9556@ucw.cz>
References: <2538186705062013113dce139@mail.gmail.com> <006f01c575d6$41b9e480$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006f01c575d6$41b9e480$600cc60a@amer.sykes.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 02:25:52PM -0600, Alejandro Bonilla wrote:

> Yani,
> 
> 	What company has ever released a Linux driver, just for the heck
> 	of it, or simply because they wanted it out? Hell no.
> 
> (maybe a couple odd ones)
> 
> We have to be persistent and ask them to release something, we paid a
> lot of money, and I have been missinformed to the fact that IBM loved
> Linux and wanted to "support it". Looks like a big lie to me. They
> don't even need to release a driver, just information. It is not even
> something that they only have. Now we all know that Analog Devices
> makes the hardware. Not them.

Motorola makes similar sensors (MMA1220D, etc). The fact that the sensor
is from AD doesn't mean anything, unfortunately, it's a generic sensor
used in videocameras (picture stabilization), digital cameras (picture
orientation detection), joysticks (logitech wingman gamepad), and many
other devices.

It's IBM (Lenovo) who interfaced it to some kind of a A/D and a
processor inside the machine that detects the free fall condition and
informs the BIOS/OS about it.

> So much for anything. I will keep asking for this information.
> 
> If people would send emails to IBM like I have, instead of complaining and
> doing pilitical arguments, we probably would have an answer already.

I believe at this moment the best approach is to track where the
connections on the mainboard go from the accelerometer. ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
