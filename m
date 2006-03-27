Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWC0UYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWC0UYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWC0UYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:24:37 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:45995 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750765AbWC0UYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:24:36 -0500
X-IronPort-AV: i="4.03,135,1141632000"; 
   d="scan'208"; a="1788797850:sNHT29785636"
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com> <442848EF.4000407@ichips.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 27 Mar 2006 12:24:32 -0800
In-Reply-To: <442848EF.4000407@ichips.intel.com> (Sean Hefty's message of "Mon, 27 Mar 2006 12:19:59 -0800")
Message-ID: <adau09j7i0v.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Mar 2006 20:24:33.0101 (UTC) FILETIME=[75677FD0:01C651DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sean> I agree that we need to let the userspace interface mature.
    Sean> And even the kernel interface could benefit from having some
    Sean> real users.  The code was added to the -mm branch, correct?

Yes, I've put both the rdma_cm and ipath branches into my for-mm
branch, so Andrew will pick them up automatically.

 - R.
