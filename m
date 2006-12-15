Return-Path: <linux-kernel-owner+w=401wt.eu-S1752961AbWLORPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbWLORPU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLORPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:15:20 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:37318 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752958AbWLORPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:15:18 -0500
Subject: Re: [PATCH 0/10] cxgb3: Chelsio T3 1G/10G ethernet device driver
From: Steve Wise <swise@opengridcomputing.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Divy Le Ray <divy@chelsio.com>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4582D60F.7020701@garzik.org>
References: <4580E3D7.3050708@chelsio.com>
	 <1166201878.2304.11.camel@stevo-desktop>  <4582D60F.7020701@garzik.org>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 11:15:18 -0600
Message-Id: <1166202919.2304.20.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 12:06 -0500, Jeff Garzik wrote:
> Steve Wise wrote:
> > Hey Jeff,
> > 
> > Is this driver in your queue for merging?  The Chelsio T3 RDMA driver
> > that depends on the T3 Ethernet driver is also ready to be merged.
> > 
> > I was just wondering if its in queue, or if there is something else we
> > need to do.
> 
> I have mainly been waiting for feedback from other developers on it, and 
> letting the driver settle down.  When its being revised on a daily 
> basis, I usually just delete the driver and wait for the next revision :)
> 
> 	Jeff

Ok, fair enough.
  
I do believe all issues/comments have been addressed for both drivers,
and the last review round only had minimal feedback.  Perhaps they're
ready now?

Steve.


