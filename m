Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751976AbWI1SRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWI1SRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWI1SRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:17:08 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:662 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751976AbWI1SRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:17:04 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 1 of 28] IB/ipath - limit # of packets sent without an ACK received
X-Message-Flag: Warning: May contain useful information
References: <c46292ccb0f54abc77f7.1159459197@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 28 Sep 2006 11:16:57 -0700
In-Reply-To: <c46292ccb0f54abc77f7.1159459197@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Thu, 28 Sep 2006 08:59:57 -0700")
Message-ID: <adafyeb5012.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Sep 2006 18:17:00.0752 (UTC) FILETIME=[4AAB7500:01C6E32A]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied all except #24 with minor comments as sent separately.

 - R.
