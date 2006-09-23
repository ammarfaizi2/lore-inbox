Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWIWBVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWIWBVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 21:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWIWBVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 21:21:50 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:53415 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S965097AbWIWBVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 21:21:49 -0400
X-IronPort-AV: i="4.09,205,1157353200"; 
   d="scan'208"; a="324498636:sNHT32590060"
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, openfabrics-ewg@openib.org, pmac@au1.ibm.com,
       Christoph.Raisch/Germany/IBM@de.ibm.com
Subject: Re: [PATCH 2.6.19-rc1] ehca firmware interface based on Anton Blanchard's new hvcall interface
X-Message-Flag: Warning: May contain useful information
References: <200609222200.12722.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 22 Sep 2006 18:21:47 -0700
In-Reply-To: <200609222200.12722.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's message of "Fri, 22 Sep 2006 22:00:12 +0200")
Message-ID: <adahcyzfkd0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Sep 2006 01:21:48.0195 (UTC) FILETIME=[A3E41F30:01C6DEAE]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I rolled this up in the ehca patch in my tree.

Anyway both Paul and I merged with Linus today, so the hcall cleanup
and ehca are both upstream.  It would be great if you could do a quick
check to make sure that ehca works in Linus's current git tree.

Thanks,
  Roland
