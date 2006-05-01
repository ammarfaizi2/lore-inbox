Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWEAWFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWEAWFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 18:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWEAWFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 18:05:43 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:10393 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932259AbWEAWFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 18:05:42 -0400
X-IronPort-AV: i="4.05,77,1146466800"; 
   d="scan'208"; a="1800335442:sNHT1689632184"
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hzhong@gmail.com
Subject: Re: [PATCH] Profile likely/unlikely macros
X-Message-Flag: Warning: May contain useful information
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 15:05:15 -0700
In-Reply-To: <200604250257.k3P2vlEb012502@dwalker1.mvista.com> (Daniel Walker's message of "Mon, 24 Apr 2006 19:57:47 -0700")
Message-ID: <adalktls8o4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 22:05:18.0713 (UTC) FILETIME=[5553EE90:01C66D6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Daniel> It has a /proc/likely_prof interface which outputs
    Daniel> something like the following,

If we're thinking of applying this to mainline then probably this file
should be in debugfs...

 - R.
