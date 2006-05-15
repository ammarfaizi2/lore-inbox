Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWEOPrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWEOPrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWEOPrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:47:07 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:21086 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751507AbWEOPrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:47:05 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14 of 53] ipath - forbid empty MRs
X-Message-Flag: Warning: May contain useful information
References: <5d9fbba3222eeb941679.1147477379@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 08:46:59 -0700
In-Reply-To: <5d9fbba3222eeb941679.1147477379@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 12 May 2006 16:42:59 -0700")
Message-ID: <adalkt3uw7g.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 15:46:59.0237 (UTC) FILETIME=[CD2B4550:01C67836]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Don't allow zero-length regions to be created.

Why are zero-length regions forbidden?

 - R.
