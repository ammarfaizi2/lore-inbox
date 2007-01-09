Return-Path: <linux-kernel-owner+w=401wt.eu-S932214AbXAIQ3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbXAIQ3Q (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbXAIQ3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:29:16 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:4641 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208AbXAIQ3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:29:14 -0500
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="758647403:sNHT77563234"
To: Jeff Garzik <jeff@garzik.org>
Cc: Divy Le Ray <divy@chelsio.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, swise@opengridcomputing.com
Subject: Re: [PATCH 1/10] cxgb3 - main header files
X-Message-Flag: Warning: May contain useful information
References: <20061220124125.6286.17148.stgit@localhost.localdomain>
	<45918CA4.3020601@garzik.org> <45A36C22.6010009@chelsio.com>
	<45A36E59.30500@garzik.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 09 Jan 2007 08:28:59 -0800
In-Reply-To: <45A36E59.30500@garzik.org> (Jeff Garzik's message of "Tue, 09 Jan 2007 05:28:41 -0500")
Message-ID: <adamz4scgfo.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Jan 2007 16:29:02.0557 (UTC) FILETIME=[45E998D0:01C7340B]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > You can grab the monolithic patch at this URL:
 > > http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
 > 
 > this is in my queue, thanks.  Sorry I didn't indicate that earlier.

When do you plan to merge it?  For 2.6.20 or .21?

I'm trying to understand when the RDMA stuff that depends on the
ethernet driver can be merged.

Thanks,
  Roland
