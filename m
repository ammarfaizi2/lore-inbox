Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbUL0N0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUL0N0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 08:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbUL0N0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 08:26:03 -0500
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:65042 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261891AbUL0N0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 08:26:00 -0500
Message-ID: <41D00D67.1010307@benton987.fsnet.co.uk>
Date: Mon, 27 Dec 2004 13:25:59 +0000
From: Andrew Benton <andy@benton987.fsnet.co.uk>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20041223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 and speedtouch usb
References: <200412271108.47578.zztchesmeli@echo.fr>
In-Reply-To: <200412271108.47578.zztchesmeli@echo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Tchesmeli wrote:
> Hi,
> 
> i have try the new kernel 2.6.10, compil with exactly the same option from my 
> 2.6.9 (i have copied the .config) but i notice a high load on my machine, and 
> i see that was syslogd.
> So, i look at my log and see:
> 
> Dec 26 19:40:44 gateway last message repeated 137 times
> Dec 26 19:40:46 gateway kernel: usb 2-1: events/0 timed out on ep0in
> Dec 26 19:40:46 gateway kernel: SpeedTouch: Error -110 fetching device status
> Dec 26 19:40:46 gateway kernel: usb 2-1: modem_run timed out on ep0in
> Dec 26 19:40:46 gateway kernel: usb 2-1: usbfs: USBDEVFS_CONTROL failed cmd 
> modem_run rqt 192 rq 18 len 8 ret -110

Are you using the kernel or userspace driver?
