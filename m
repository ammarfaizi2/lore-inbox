Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422838AbWI2Vqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWI2Vqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbWI2Vqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:46:44 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:13396 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1422838AbWI2Vqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:46:43 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ipath - fix RDMA reads
X-Message-Flag: Warning: May contain useful information
References: <7b2b5b33a24891601ac1.1159565871@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 29 Sep 2006 14:46:42 -0700
In-Reply-To: <7b2b5b33a24891601ac1.1159565871@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 29 Sep 2006 14:37:51 -0700")
Message-ID: <adaven6z6pp.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Sep 2006 21:46:42.0763 (UTC) FILETIME=[C08BB9B0:01C6E410]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied (I assumed Ralph was the author when merging, please
let me know if that was wrong)
