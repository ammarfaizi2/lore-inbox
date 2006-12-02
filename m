Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936589AbWLBXQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936589AbWLBXQh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 18:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936585AbWLBXQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 18:16:37 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:2444 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S933754AbWLBXQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 18:16:36 -0500
Date: Sun, 3 Dec 2006 00:13:30 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 00/13] 2.6.20 Chelsio T3 RDMA Driver
Message-ID: <20061202231329.GA10719@electric-eye.fr.zoreil.com>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202224917.27014.15424.stgit@dell3.ogc.int>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Wise <swise@opengridcomputing.com> :
[...]
> Version 2 changes:
> 
> - Make code sparse endian clean
> - Use IDRs for mapping QP and CQ IDs to structure pointers instead of arrays
> - Clean up confusing bitfields
> - Use random32() instead of local random function
> - Use krefs to track endpoint reference counts
> - Misc nits
> 
> -----
> 
> The following series implements the Chelsio T3 iWARP/RDMA Driver to
> be considered for inclusion in 2.6.20.  It depends on the Chelsio T3
> Ethernet Driver which is also under review now for 2.6.20. See:

I understood that Stephen expressed some doubts regarding the inclusion
of TOE enabled features.

Was his point addressed ?

-- 
Ueimor
