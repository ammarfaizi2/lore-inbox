Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWDCPq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWDCPq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWDCPq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:46:56 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:41301 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751748AbWDCPqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:46:55 -0400
X-IronPort-AV: i="4.03,159,1141632000"; 
   d="scan'208"; a="266208210:sNHT30223416"
To: "Dan Bar Dov" <bardov@gmail.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com>
	<d6944c490603290028n70725678g287445429a9c2ae5@mail.gmail.com>
	<ada7j6d89oz.fsf@cisco.com>
	<d6944c490604030331s78ba93dap3496b10a08d81326@mail.gmail.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 03 Apr 2006 08:46:52 -0700
In-Reply-To: <d6944c490604030331s78ba93dap3496b10a08d81326@mail.gmail.com> (Dan Bar Dov's message of "Mon, 3 Apr 2006 12:31:20 +0200")
Message-ID: <ada3bguwtjn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Apr 2006 15:46:54.0279 (UTC) FILETIME=[D4DD3D70:01C65735]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dan> On the other hand, there are user-space consumers for CMA,
    Dan> such as udapl, so although ISER will attempt only at 2.6.18,
    Dan> maybe it is a good idea to get CMA into 2.6.17

Well, too late now anyway.

But Sean and I agreed that the userspace interface to CMA was not
mature enough to merge for 2.6.17.

 - R.
