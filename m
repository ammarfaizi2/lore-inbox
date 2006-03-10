Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWCJABP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWCJABP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbWCJABP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:01:15 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:18040 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750900AbWCJABO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:01:14 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="260913991:sNHT31542816"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 16:01:13 -0800
In-Reply-To: <1141948516.10693.55.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 15:55:16 -0800")
Message-ID: <ada1wxbdv7a.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 00:01:13.0291 (UTC) FILETIME=[BEAF91B0:01C643D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Any idea what I should be using instead?

It depends what you're trying to do.  Hence my original question: why
are you doing SetPageReserved?

 - R.
