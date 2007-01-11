Return-Path: <linux-kernel-owner+w=401wt.eu-S1751409AbXAKTRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXAKTRY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbXAKTRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:17:24 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:43282 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXAKTRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:17:23 -0500
X-IronPort-AV: i="4.13,174,1167638400"; 
   d="scan'208"; a="759018136:sNHT62366344"
To: Christoph Hellwig <hch@infradead.org>
Cc: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 1/5] ehca: declaration of queue structures
X-Message-Flag: Warning: May contain useful information
References: <200701112007.49620.hnguyen@linux.vnet.ibm.com>
	<20070111191425.GA24623@infradead.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 Jan 2007 11:17:21 -0800
In-Reply-To: <20070111191425.GA24623@infradead.org> (Christoph Hellwig's message of "Thu, 11 Jan 2007 19:14:25 +0000")
Message-ID: <adaac0pl6f2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Jan 2007 19:17:21.0525 (UTC) FILETIME=[1E315250:01C735B5]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > This indentation changes moves away from the preffered form.

I will fix when I merge it -- no need to resend.

 > Except for that the patch looks fine.

Christoph, did you look over all 5 or just this one so far?

Thanks,
  Roland
