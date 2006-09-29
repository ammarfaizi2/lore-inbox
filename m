Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWI2Vjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWI2Vjj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWI2Vji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:39:38 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:12327 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932386AbWI2Vjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:39:37 -0400
X-IronPort-AV: i="4.09,238,1157353200"; 
   d="scan'208"; a="1855949225:sNHT45792916"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ipath - fix RDMA reads
X-Message-Flag: Warning: May contain useful information
References: <7b2b5b33a24891601ac1.1159565871@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 29 Sep 2006 14:39:32 -0700
In-Reply-To: <7b2b5b33a24891601ac1.1159565871@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 29 Sep 2006 14:37:51 -0700")
Message-ID: <ada4puq1hez.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Sep 2006 21:39:32.0974 (UTC) FILETIME=[C05F20E0:01C6E40F]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume this is 'From: Ralph Campbell <ralph.campbell@qlogic.com>'
(based on the sign-off)?
