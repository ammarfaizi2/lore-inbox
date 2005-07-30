Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbVG3PBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbVG3PBe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVG3PBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:01:34 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:8623 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262981AbVG3PBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:01:33 -0400
Message-ID: <42EB9650.8010305@m1k.net>
Date: Sat, 30 Jul 2005 11:01:36 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Schau <brian@schau.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
References: <42EB940E.5000008@schau.com>
In-Reply-To: <42EB940E.5000008@schau.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Schau wrote:

> I've attached a gzipped version of my Wireless Security Lock patch
> for v2.6.13-rc4.
> The WSL driver touches these files:
>
>     drivers/usb/Makefile            (1 line)
>     drivers/usb/input/Kconfig        (10 lines)
>     drivers/usb/input/Makefile        (1 line)
>     drivers/usb/input/hid-core.c        (2 lines)
>     drivers/usb/input/wsl.c            (224 lines)
>
> This is my first driver for Linux - feel free to harass me if I am
> not following procedures or you think the driver is lame.  Better still,
> educate me :-)

Please don't take this as harassment, but this mailing list [LKML] is 
archieved all over the internet... In order for people to see your 
patch, you should re-send your patch to the list as INLINE text, or as a 
text attachment.  My mailer sends my text attachments as inline text, 
but I don't think every mailer does the same...

Most people on this list will be happy to look at your patch and harass 
you / applaud you about it, but only if they don't have to jump through 
hoops in order to see it ;-)

keep patching...

-- 
Michael Krufky

