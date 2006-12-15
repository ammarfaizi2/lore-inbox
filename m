Return-Path: <linux-kernel-owner+w=401wt.eu-S1751689AbWLORG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWLORG1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbWLORG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:06:26 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:56286 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbWLORG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:06:26 -0500
Message-ID: <4582D60F.7020701@garzik.org>
Date: Fri, 15 Dec 2006 12:06:23 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Steve Wise <swise@opengridcomputing.com>
CC: Divy Le Ray <divy@chelsio.com>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/10] cxgb3: Chelsio T3 1G/10G ethernet device driver
References: <4580E3D7.3050708@chelsio.com> <1166201878.2304.11.camel@stevo-desktop>
In-Reply-To: <1166201878.2304.11.camel@stevo-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Wise wrote:
> Hey Jeff,
> 
> Is this driver in your queue for merging?  The Chelsio T3 RDMA driver
> that depends on the T3 Ethernet driver is also ready to be merged.
> 
> I was just wondering if its in queue, or if there is something else we
> need to do.

I have mainly been waiting for feedback from other developers on it, and 
letting the driver settle down.  When its being revised on a daily 
basis, I usually just delete the driver and wait for the next revision :)

	Jeff



