Return-Path: <linux-kernel-owner+w=401wt.eu-S932436AbXAIWFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbXAIWFA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbXAIWFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:05:00 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:48428 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbXAIWE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:04:58 -0500
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Cc: rolandd@cisco.com, openib-general@openib.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.20] ehca: use proper flag for get_zeroed_page() to prevent BUG:scheduling while atomic...
X-Message-Flag: Warning: May contain useful information
References: <200701091804.14297.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 09 Jan 2007 14:04:54 -0800
In-Reply-To: <200701091804.14297.hnguyen@linux.vnet.ibm.com> (Hoang-Nam Nguyen's message of "Tue, 9 Jan 2007 18:04:14 +0100")
Message-ID: <adazm8r3lh5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Jan 2007 22:04:55.0227 (UTC) FILETIME=[31D700B0:01C7343A]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
