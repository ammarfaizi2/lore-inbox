Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVHLVbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVHLVbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVHLVa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:30:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:13741 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750906AbVHLVak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:30:40 -0400
Message-ID: <42FD14FB.3060200@pobox.com>
Date: Fri, 12 Aug 2005 17:30:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: SATA status report updated
References: <42FC2EF8.7030404@pobox.com> <E1E3X1A-00081t-00@chiark.greenend.org.uk>
In-Reply-To: <E1E3X1A-00081t-00@chiark.greenend.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Things in SATA-land have been moving along recently, so I updated the 
>>software status report:
>>
>>	http://linux.yyz.us/sata/software-status.html
> 
> 
> I couldn't see any reference to system-wide power management (ie,
> suspend/resume of machines with SATA interfaces) - is any work going on
> in that area at the moment?

Jens Axboe @ SuSE posted a patch that needs some work.  So, it's on the 
radar screen, but I haven't seen any new work recently.

	Jeff



