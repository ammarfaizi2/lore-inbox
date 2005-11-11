Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVKKKSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVKKKSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVKKKSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:18:10 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:11695
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751268AbVKKKSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:18:09 -0500
Message-Id: <43747E39.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 11 Nov 2005 11:19:21 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/39] NLKD - an alternative early ioremap approach
References: <43720DAE.76F0.0078.0@novell.com>  <43720E2E.76F0.0078.0@novell.com>  <43720E72.76F0.0078.0@novell.com> <20051111100612.GA27805@elf.ucw.cz>
In-Reply-To: <20051111100612.GA27805@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ouch and btw the patch is wrong in first hunk, it adds #else/#endif
>without #ifdef. Ouch.

It only adds #else, #if and #endif already exist...

Jan
