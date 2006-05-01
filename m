Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWEAScM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWEAScM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWEAScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:32:12 -0400
Received: from test-iport-1.cisco.com ([171.71.176.117]:18875 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751034AbWEAScL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:32:11 -0400
To: Or Gerlitz <ogerlitz@voltaire.com>
Cc: openib-general@openib.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] iSER (iSCSI Extensions for RDMA) initiator
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.44.0604271528140.16463-100000@zuben>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 11:32:08 -0700
In-Reply-To: <Pine.LNX.4.44.0604271528140.16463-100000@zuben> (Or Gerlitz's message of "Thu, 27 Apr 2006 15:30:03 +0300 (IDT)")
Message-ID: <adar73dvbo7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 18:32:09.0793 (UTC) FILETIME=[8E899B10:01C66D4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this ready for queuing in my for-2.6.18 tree?  What is the status
of all the non-IB dependencies?

If it is ready for merging, please send me a clean patch series with
the comments from this thread addressed.  And also remind me of which
SCSI git trees this depends on...

Thanks,
  Roland
