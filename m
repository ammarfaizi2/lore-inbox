Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbWHRQbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbWHRQbR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWHRQbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:31:17 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:37 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751407AbWHRQbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:31:16 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: Re: InfiniBand merge plans for 2.6.19
X-Message-Flag: Warning: May contain useful information
References: <adawt9786ii.fsf@cisco.com>
	<20060818162135.GA20206@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 18 Aug 2006 09:31:09 -0700
In-Reply-To: <20060818162135.GA20206@mellanox.co.il> (Michael S. Tsirkin's message of "Fri, 18 Aug 2006 19:21:35 +0300")
Message-ID: <adahd0a80qa.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 Aug 2006 16:31:12.0128 (UTC) FILETIME=[B7A89000:01C6C2E3]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> Cold you oplease consider IB/mthca: recover from device
    Michael> errors as well?

Yes, I will.  There's still plenty of time before 2.6.19 opens up.
