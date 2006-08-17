Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWHQUbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWHQUbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWHQUbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:31:42 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:154 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1030271AbWHQUbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:31:40 -0400
X-IronPort-AV: i="4.08,139,1154934000"; 
   d="scan'208"; a="1848224268:sNHT59256530"
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com
Subject: Re: [openib-general] [PATCH 00/16] IB/ehca: introduction
X-Message-Flag: Warning: May contain useful information
References: <2006817139.43eVtRoa2IK8yOPl@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 17 Aug 2006 13:31:37 -0700
In-Reply-To: <2006817139.43eVtRoa2IK8yOPl@cisco.com> (Roland Dreier's message of "Thu, 17 Aug 2006 13:09:27 -0700")
Message-ID: <adasljv85p2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Aug 2006 20:31:39.0178 (UTC) FILETIME=[246FF0A0:01C6C23C]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry-- my patchbombing script blew up in the middle, and I didn't
restart quite correctly.  But I'm pretty sure all 16 patches did make
it out, although the numbering is screwy.  The correct series is:

    01/16, 02/16, 00/13, 01/13, ..., 13/13

I'm not going to spam everybody and resend to all the lists, but I'm
happy to resend privately to anyone who asks, or you can clone the
git tree to get the series

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git ehca

Thanks,
  Roland
