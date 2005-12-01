Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVLAIQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVLAIQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVLAIQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:16:26 -0500
Received: from mail.dvmed.net ([216.237.124.58]:48321 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751395AbVLAIQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:16:25 -0500
Message-ID: <438EB150.2090502@pobox.com>
Date: Thu, 01 Dec 2005 03:16:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Linus Torvalds <torvalds@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org> <438D69FF.2090002@aitel.hist.no>
In-Reply-To: <438D69FF.2090002@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Helge Hafting wrote: > I tried compiling and booting
	rc1. The machine is remote, and did not > come up. So I don't know why
	it didn't come up, but it is likely > that it is the same problem. Any
	chance at all to get netconsole or serial console output, after turning
	on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h ? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> I tried compiling and booting rc1.  The machine is remote, and did not
> come up.  So I don't know why it didn't come up, but it is likely
> that it is the same problem.

Any chance at all to get netconsole or serial console output, after 
turning on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h ?

	Jeff


