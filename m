Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966731AbWKTVF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966731AbWKTVF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966732AbWKTVF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:05:27 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:44582 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S966731AbWKTVF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:05:26 -0500
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: lkml <linux-kernel@vger.kernel.org>, randy.dunlap@ORACLE.COM,
       openib-general@openib.org
Subject: Re: ipath uses skb functions
X-Message-Flag: Warning: May contain useful information
References: <20061119125106.0ea9541e.randy.dunlap@oracle.com>
	<4561F9EA.1020402@serpentine.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Nov 2006 13:05:21 -0800
In-Reply-To: <4561F9EA.1020402@serpentine.com> (Bryan O'Sullivan's message of "Mon, 20 Nov 2006 10:54:34 -0800")
Message-ID: <adak61phlri.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Nov 2006 21:05:22.0277 (UTC) FILETIME=[978A9950:01C70CE7]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
