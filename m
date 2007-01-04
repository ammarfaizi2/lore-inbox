Return-Path: <linux-kernel-owner+w=401wt.eu-S1030235AbXADVUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbXADVUr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbXADVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:20:47 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:12165 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030235AbXADVUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:20:46 -0500
X-IronPort-AV: i="4.12,239,1165219200"; 
   d="scan'208"; a="98147588:sNHT55079046"
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <hnguyen@de.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: do we have mmap abuse in ehca ?, was Re:  mmap abuse in ehca
X-Message-Flag: Warning: May contain useful information
References: <20061219113502.GA1416@infradead.org>
	<OF78487656.FBBD715F-ONC125724A.00287BE6-C125724A.002F4756@de.ibm.com>
	<20061220115116.GA25709@infradead.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 04 Jan 2007 13:20:40 -0800
In-Reply-To: <20061220115116.GA25709@infradead.org> (Christoph Hellwig's message of "Wed, 20 Dec 2006 11:51:16 +0000")
Message-ID: <ada8xgi5w0n.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Jan 2007 21:20:42.0666 (UTC) FILETIME=[30B990A0:01C73046]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I missed this original thread (on vacation since mid-December,
just back today).  Anyway...

ehca guys -- where do we stand on fixing this up?
