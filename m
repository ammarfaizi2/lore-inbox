Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWEJR0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWEJR0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWEJR0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:26:24 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:39952 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S965018AbWEJR0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:26:23 -0400
X-IronPort-AV: i="4.05,110,1146466800"; 
   d="scan'208"; a="274609981:sNHT539213004"
To: Or Gerlitz <ogerlitz@voltaire.com>
Cc: openib-general@openib.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] iSER (iSCSI Extensions for RDMA) initiator
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.44.0605101618360.17835-100000@zuben>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 10 May 2006 10:26:17 -0700
In-Reply-To: <Pine.LNX.4.44.0605101618360.17835-100000@zuben> (Or Gerlitz's message of "Wed, 10 May 2006 16:20:30 +0300 (IDT)")
Message-ID: <adak68t94g6.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 May 2006 17:26:20.0782 (UTC) FILETIME=[DA7618E0:01C67456]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Or> To have this code compiled you would need to get the iscsi
    Or> updates for 2.6.18 into your source tree, that is pull/sync
    Or> with include/scsi and drivers/scsi of the scsi-misc-2.6 git
    Or> tree.

What is the URL of this git tree?

(Since git works on changesets and not on paths a la CVS, I can only
pull the whole tree rather than selecting certain paths; but I don't
think that matters)

    Or> There's one patch which is not yet merged there and without it
    Or> iser's compilation fails. The patch is named "iscsi: add
    Or> transport end point callbacks" and i will send it to you
    Or> offlist.

Please let me know when it is merged.  I don't want to be merging
iSCSI changes via my tree.

 - R.
