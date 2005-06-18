Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVFRQxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVFRQxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 12:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVFRQxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 12:53:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:8595 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262153AbVFRQxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 12:53:13 -0400
Message-ID: <42B45173.6060209@pobox.com>
Date: Sat, 18 Jun 2005 12:53:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
References: <200506181332.25287.nick@linicks.net>
In-Reply-To: <200506181332.25287.nick@linicks.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> New 2.6.12 build hangs at initialising udev dynamic device directory on boot.  


Did you try simply waiting a while?

udev took a long time to initialize (30-40 seconds) for me, then 
everything worked and the machine booted just fine.

I've seen this on both new and old udev.  Some patience will fix things :)

	Jeff


