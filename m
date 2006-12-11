Return-Path: <linux-kernel-owner+w=401wt.eu-S1762381AbWLKECX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762381AbWLKECX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762388AbWLKECX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:02:23 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:28067 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762380AbWLKECV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:02:21 -0500
To: Steve Wise <swise@opengridcomputing.com>
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v3 00/13] 2.6.20 Chelsio T3 RDMA Driver
X-Message-Flag: Warning: May contain useful information
References: <20061210223244.27166.36192.stgit@dell3.ogc.int>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 10 Dec 2006 20:02:20 -0800
Message-ID: <adafybn2i7n.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Dec 2006 04:02:20.0634 (UTC) FILETIME=[27E7EBA0:01C71CD9]
Authentication-Results: sj-dkim-5; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim5002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't seen any evidence of the corresponding ethernet NIC driver
being merged for 2.6.20 (which is a prerequisite, right).

What's the status of that?

 - R.
