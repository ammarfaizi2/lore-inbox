Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUGPRi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUGPRi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUGPRi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:38:57 -0400
Received: from b.mail.peak.org ([69.59.192.42]:14600 "EHLO b.mail.peak.org")
	by vger.kernel.org with ESMTP id S266534AbUGPRiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:38:55 -0400
Date: Fri, 16 Jul 2004 10:39:32 -0700
To: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
References: <10898500322333@kroah.com> <10898500321009@kroah.com> <20040716170716.GD8264@openzaurus.ucw.cz> <20040716171702.GA10598@kroah.com>
From: Bob Riegelmann <bobr@casco.net>
Organization: Who? Me?
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opsa8rb6g8othr9z@mail.peak.org>
In-Reply-To: <20040716171702.GA10598@kroah.com>
User-Agent: Opera7.23/Linux M2 build 518
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004 10:17:03 -0700, Greg KH <greg@kroah.com> wrote:

> On Fri, Jul 16, 2004 at 07:07:16PM +0200, Pavel Machek wrote:
<snip>
>> Just out of curiosity... are such devices really connected using one 
>> wire only,
>> or is it GND+5V+one data wire, or GND+power&data wire?
>
> I'm pretty sure it's just 1 wire, at least for the devices I've seen.

I work with these all the time - it's power & data one one pin, and some 
kind of a ground.  They also make some in 3 terminal packages (pinouts can 
be had on the Maxim site). That said, I'm really pleased to see this in 
the kernel - as I'm in the process of developing all the firmware to port 
one of our product to use Linux! The application guys are way ahead of me, 
however...

Enjoy

Bob Riegelmann

