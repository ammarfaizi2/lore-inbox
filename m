Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268737AbUHaQJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbUHaQJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268754AbUHaQJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:09:37 -0400
Received: from dev.tequila.jp ([128.121.50.153]:61190 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S268737AbUHaQJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:09:32 -0400
Message-ID: <4134A2B3.1010008@tequila.co.jp>
Date: Wed, 01 Sep 2004 01:09:23 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in 2.6.8.1-mm4 and usb
References: <4134445B.3040400@tequila.co.jp>
In-Reply-To: <4134445B.3040400@tequila.co.jp>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:
> Hi,

> So I could mount it and then copied some files there. But when I tried
> to unmount the disk light on the iriver never went of. So after ~1 hour
> I just pulled the usb cable. I got the oops (see below). The files where
> never copied to the device at the end.
> 
> System is a debian unstable. Kernel 2.6.8.1-mm4, config file attached.

One more thing: this oops *always* happens on unmount or usb shutdown. 
eg when I shutdown the system and the iRiver is still connected. That 
oops gets thrown and the system doesn't shutdown anymore.

lg, clemens
