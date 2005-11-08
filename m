Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVKHRHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVKHRHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVKHRHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:07:42 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:16739
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965012AbVKHRHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:07:42 -0500
Message-Id: <4370E9A2.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 18:08:34 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: make trap information available to die
	handlers
References: <4370AEE1.76F0.0078.0@novell.com>  <4370E5C4.76F0.0078.0@novell.com> <Pine.LNX.4.58.0511080853360.15288@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0511080853360.15288@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And the patch (attachment) also contains From:, but it's missing
>a Signed-off-by: line.

I looked at many ChangeLog entries (which supposedly get created from
the abstract), and by far not all of them have the author listed both as
From: and Singed-Off-By:, which made me think that either of the two
should be sufficient (and I really can't see why the author information
needs to appear twice).

Jan
