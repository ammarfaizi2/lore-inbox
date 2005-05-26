Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVEZPvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVEZPvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVEZPvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:51:05 -0400
Received: from mail-public.northwestel.net ([198.235.201.66]:59376 "EHLO
	yk-pvtmailprd-01.internal.messaging") by vger.kernel.org with ESMTP
	id S261574AbVEZPu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:50:59 -0400
Date: Thu, 26 May 2005 08:31:23 -0700
From: Richard Whittaker <rwhittaker@northwestel.ca>
Subject: DHCP options in kernel...
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <4295EBCB.5030307@northwestel.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya..

I'm trying to setup a diskless boot system using a Debian Sarge base, 
and everything's going well, but I've run into one snag... I want the 
DHCP server to dynamically generate hostnames based on MAC addresses, 
and supply those to the clients, and that part's working just fine. 
However, the client (a diskless kernel) isn't taking the hostname and 
applying it to itself... Is there an option that I can pass to the 
kernel that functions like dhcpcd -H, or does something need to be 
kludged at the debian end?...

Thanks,
Richard.


