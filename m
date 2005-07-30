Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVG3WF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVG3WF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 18:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVG3WF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 18:05:27 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:63705 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S262928AbVG3WFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 18:05:25 -0400
Message-ID: <42EBF9D2.7020403@schau.com>
Date: Sun, 31 Jul 2005 00:06:10 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz> <42EBDEA9.60505@schau.com> <20050730203159.GB9418@elf.ucw.cz> <42EBEDB1.7020802@schau.com> <20050730211636.GD9418@elf.ucw.cz>
In-Reply-To: <20050730211636.GD9418@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part of what I do is to tell input to keep hands of the device
(in hid-core.c).

I have tried to contact vojtech - I sent him the patches earlier
this week but I got no response.  He's probably on vacation or so :-)

Ah well ...


Pavel Machek wrote:
> Hi!
> 
> 
>>I (and others) have tried using combinations of libusb/userland
>>stuff - but have failed miserably.
> 
> 
> You may need to patch input to keep hands off that device, but the
> rest should be doable using libusb, right? Or talk to vojtech, using
> input devices should devices without libusb should be possible too. 
> 
> 								Pavel
