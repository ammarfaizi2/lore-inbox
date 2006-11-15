Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966529AbWKOA0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966529AbWKOA0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 19:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966530AbWKOA0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 19:26:17 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:40715 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S966529AbWKOA0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 19:26:16 -0500
Message-ID: <455A5E93.6050709@shadowen.org>
Date: Wed, 15 Nov 2006 00:25:55 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org>	<20061114184919.GA16020@skynet.ie>	<Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> <20061114113120.d4c22b02.akpm@osdl.org>
In-Reply-To: <20061114113120.d4c22b02.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing this too.  Will try this patch out on the affected machines.

If there are any others you recommend with it.  Yell.

-apw
