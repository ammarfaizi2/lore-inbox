Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbVKIRTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbVKIRTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVKIRTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:19:09 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37969
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932696AbVKIRTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:19:06 -0500
Message-Id: <43723DD5.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 18:20:05 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/39] NLKD - an alternative kallsyms approach
References: <43720DAE.76F0.0078.0@novell.com>  <43720E2E.76F0.0078.0@novell.com> <Pine.LNX.4.58.0511090847590.4001@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0511090847590.4001@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>BTW, are you posting these just for comments or did you want
>someone to apply/merge them?  If so, who?  You should send them
>to that someone (unless you have some other arrangements) --
>at least that's the normal procedure.

I don't expect the debugger itself to be merged, but I hope the
preparatory pieces could be. And then, if not Andrew (who, as far as I
can see, picks up things from the list just as much as stuff directly
addressed to him), who would I send this to? There's doesn't seem to be
a clear maintainer of i386, for example, and that seems to be the case
for many other parts, too.

Jan
