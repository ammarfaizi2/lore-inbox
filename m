Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWCFWlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWCFWlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWCFWlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:41:25 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:52316 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932422AbWCFWlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:41:24 -0500
X-IronPort-AV: i="4.02,169,1139212800"; 
   d="scan'208"; a="259923909:sNHT30129976"
To: "David S. Miller" <davem@davemloft.net>
Cc: mshefty@ichips.intel.com, sean.hefty@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <adabqwj5j7b.fsf@cisco.com>
	<20060306.142814.109285730.davem@davemloft.net>
	<aday7zn432b.fsf@cisco.com>
	<20060306.143901.26500391.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 14:41:21 -0800
In-Reply-To: <20060306.143901.26500391.davem@davemloft.net> (David S. Miller's message of "Mon, 06 Mar 2006 14:39:01 -0800 (PST)")
Message-ID: <adau0ab42ni.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2006 22:41:22.0411 (UTC) FILETIME=[17DC0BB0:01C6416F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> I wrote a test program and it looks ok:

Cool, thanks.

I should look into getting some niagara machines to test with -- with
PCIe slots they should actually be good for IB testing.

 - R.
