Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVCLFGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVCLFGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 00:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVCLFGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 00:06:38 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45394 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261875AbVCLFGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 00:06:36 -0500
Date: Fri, 11 Mar 2005 23:06:30 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken,
 centrino speedstep even more broken than in 2.6.10
In-reply-to: <3GZyA-16B-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <423278D6.2090603@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3GZyA-16B-17@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> My new nForce 4 mainboard has 10 or so USB 2.0 outlets.  In Windows,
> they all work.  In Linux, two of them work.  Putting my USB stick or
> anything else in one of the others produces nothing in Linux.
> Apparently no IRQ getting through or something?

Likely similar to the problem I reported in this thread on 
linux-usb-devel - the patch that David Brownell posted fixed the problem 
for me..

http://sourceforge.net/mailarchive/message.php?msg_id=10755097


