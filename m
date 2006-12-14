Return-Path: <linux-kernel-owner+w=401wt.eu-S1751964AbWLNGO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbWLNGO7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbWLNGO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:14:58 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:8716 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbWLNGO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:14:58 -0500
X-Greylist: delayed 2050 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 01:14:57 EST
Message-ID: <4580E3D7.3050708@chelsio.com>
Date: Wed, 13 Dec 2006 21:40:39 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/10] cxgb3: Chelsio T3 1G/10G ethernet device driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2006 05:40:42.0188 (UTC) FILETIME=[64BED8C0:01C71F42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I resubmit the patch supporting the latest Chelsio T3 adapter.
It incorporates the last feedbacks for code cleanup.
It is built gainst Linus'tree.

We think the driver is now ready to be merged.
Can you please advise on the next steps for inclusion in 2.6.20 ?

A corresponding monolithic patch is posted at the following URL:
http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

This driver is required by the Chelsio T3 RDMA driver
which was updated on 12/10/2006.

Cheers,
Divy

