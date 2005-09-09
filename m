Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVIIJi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVIIJi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVIIJi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:38:58 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:7701
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030191AbVIIJi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:38:57 -0400
Message-Id: <4321749202000078000248C5@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 11:40:02 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
References: <43207D28020000780002451E@emea1-mh.id2.novell.com>  <200509091054.11932.ak@suse.de>  <43216EFB020000780002489B@emea1-mh.id2.novell.com> <200509091123.59205.ak@suse.de>
In-Reply-To: <200509091123.59205.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But why would anyone want frame pointers on x86-64?

I'd put the question differently: Why should x86-64 not allow what
other architectures do?

But of course, I'm not insisting on this patch to get in, it just
seemed an obvious inconsistency...

Jan
