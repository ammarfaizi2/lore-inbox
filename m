Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424412AbWKPTlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424412AbWKPTlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424409AbWKPTlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 14:41:23 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:53435 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1424407AbWKPTlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 14:41:22 -0500
To: Steve Wise <swise@opengridcomputing.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH  01/13] Linux RDMA Core Changes
X-Message-Flag: Warning: May contain useful information
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
	<20061116035831.22635.95377.stgit@dell3.ogc.int>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Nov 2006 11:41:20 -0800
In-Reply-To: <20061116035831.22635.95377.stgit@dell3.ogc.int> (Steve Wise's message of "Wed, 15 Nov 2006 21:58:32 -0600")
Message-ID: <ada4pszrxgf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Nov 2006 19:41:20.0979 (UTC) FILETIME=[310A9230:01C709B7]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks completely sane to me, so I have no problem merging this
stuff once the rest of the Chelsio-specific stuff is reviewed.

 - R.
