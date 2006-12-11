Return-Path: <linux-kernel-owner+w=401wt.eu-S1762452AbWLKFC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762452AbWLKFC1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 00:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762453AbWLKFC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 00:02:27 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:21851 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762451AbWLKFCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 00:02:25 -0500
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v3 13/13] Kconfig/Makefile
X-Message-Flag: Warning: May contain useful information
References: <20061210223244.27166.36192.stgit@dell3.ogc.int>
	<20061210223916.27166.82130.stgit@dell3.ogc.int>
	<20061210145602.d2a8bb98.randy.dunlap@oracle.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 10 Dec 2006 21:02:20 -0800
Message-ID: <adaac1v2ffn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Dec 2006 05:02:20.0802 (UTC) FILETIME=[89C5F620:01C71CE1]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > +++ b/drivers/infiniband/hw/cxgb3/locking.txt

 > Should be in Documentation/infiniband/.
 > Docs go in the Documentation/ dir, not in drivers/ dir.

Or put it in a comment in the appropriate header, if you want to keep
it close to the driver source...
