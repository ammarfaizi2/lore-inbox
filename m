Return-Path: <linux-kernel-owner+w=401wt.eu-S1751310AbXAIKnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbXAIKnt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbXAIKnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:43:49 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33664 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbXAIKnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:43:49 -0500
Message-ID: <45A371E3.9090103@garzik.org>
Date: Tue, 09 Jan 2007 05:43:47 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Maarten Vanraes <maarten.vanraes@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AHCI IDENTIFY problem only on x86_64
References: <6f61137b0701090235g2ea3f4a2j2d5e985ef70b142a@mail.gmail.com>
In-Reply-To: <6f61137b0701090235g2ea3f4a2j2d5e985ef70b142a@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maarten Vanraes wrote:
> I would like to be CC'ed as i'm not on the list.
> 
> kernel 2.16.17.13: in 32bit the disk is detected everything ok, in
> x86_64, it gives a Failed to IDENTIFY for both drives, it does not
> give a FAILED to IDENTIFY on the ones where the link is down.
> 
> any idea what the problem is?

May we presume that 2.6.20-rc4 works?

	Jeff



