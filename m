Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbUBXBPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUBXBPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:15:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39104 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262149AbUBXBJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:09:44 -0500
Message-ID: <403AA44B.8060404@pobox.com>
Date: Mon, 23 Feb 2004 20:09:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Dowideit <svenud@ozemail.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel: NETDEV WATCHDOG: eth0: transmit timed out
References: <1077457080.1208.17.camel@sven>
In-Reply-To: <1077457080.1208.17.camel@sven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Dowideit wrote:
> I have an IBM thinkpad T21 that has a 3Com ethernet card that has not
> been working in a long while (with ACPI turned on).
> 
> Recently (the last 2-3 releases or so) it has also been getting the
> following messages (until i remember to to an ifconfgi eth0 down)
> 
> Feb 23 00:22:00 sven kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Feb 23 00:22:35 sven last message repeated 3 times
> Feb 23 00:23:35 sven last message repeated 5 times
> Feb 23 00:24:35 sven last message repeated 5 times
> Feb 23 00:25:35 sven last message repeated 5 times
> Feb 23 00:26:00 sven last message repeated 2 times


Does it work with ACPI disabled?

	Jeff



