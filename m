Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWHYUBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWHYUBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWHYUBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:01:36 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:18530 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S964850AbWHYUBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:01:35 -0400
X-IronPort-AV: i="4.08,169,1154934000"; 
   d="scan'208"; a="1850385697:sNHT34669700"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 23] IB/ipath - More changes to support InfiniPath on PowerPC 970 systems
X-Message-Flag: Warning: May contain useful information
References: <44809b730ac95b39b672.1156530266@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 25 Aug 2006 13:01:20 -0700
In-Reply-To: <44809b730ac95b39b672.1156530266@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 25 Aug 2006 11:24:26 -0700")
Message-ID: <adazmdsshyn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Aug 2006 20:01:34.0188 (UTC) FILETIME=[43E252C0:01C6C881]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Signed-off-by: John Gregor <john.gregor@qlogic.com>

I assume this patch was actually written by John Gregor?  If so you
should include an extra "From:" line in the body of the email, so that
the authorship information gets put into git correctly.

 - R.
