Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423930AbWKHXJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423930AbWKHXJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423948AbWKHXJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:09:01 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:2336 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1423930AbWKHXI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:08:59 -0500
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="449181677:sNHT46498276"
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org
Subject: Re: [PATCH 2.6.19 4/4] ehca: ehca_av.c use constant for max mtu
X-Message-Flag: Warning: May contain useful information
References: <200611052142.56722.hnguyen@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 08 Nov 2006 15:08:58 -0800
In-Reply-To: <200611052142.56722.hnguyen@de.ibm.com> (Hoang-Nam Nguyen's message of "Sun, 5 Nov 2006 21:42:56 +0100")
Message-ID: <ada64dpfsdx.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Nov 2006 23:08:58.0784 (UTC) FILETIME=[DF2AC200:01C7038A]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've applied 1 through 4.
