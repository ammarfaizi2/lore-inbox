Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWC3XL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWC3XL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWC3XL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:11:27 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:30298 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751120AbWC3XL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:11:26 -0500
To: openib-general@openib.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [openib-general] updated InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com> <ada1wwj1r7r.fsf@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 30 Mar 2006 15:11:17 -0800
In-Reply-To: <ada1wwj1r7r.fsf@cisco.com> (Roland Dreier's message of "Thu, 30 Mar 2006 14:51:36 -0800")
Message-ID: <adawtebzfxm.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Mar 2006 23:11:19.0701 (UTC) FILETIME=[410ABC50:01C6544F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh yeah, one other thing I plan to merge unless someone objects:

 * Get rid of option for building IPoIB and mthca debug output unless EMBEDDED=y

 - R.
