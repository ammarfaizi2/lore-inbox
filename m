Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVKIRNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVKIRNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVKIRNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:13:10 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:42064
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751418AbVKIRNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:13:09 -0500
Message-Id: <43723C6D.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 18:14:05 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
References: <43720DAE.76F0.0078.0@novell.com>  <43722AFC.4040709@pobox.com> <Pine.LNX.4.58.0511090904320.4001@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0511090904320.4001@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On the surface I have to agree.  However, if Jan wants feedback
>on the patches, that's a reasonable request IMO.

Getting feedback is not the only goal.

>(but they need to be readable via email so that someone
>can comment on them)

Sorry, I hear this quite often, but I also have to play by some company
rules, one of which is to use a certain mail system (or otherwise be
left alone in case of problems).

>At a quick blush, I would guess it has as much chance as
>kdb does (or did) for merging.

The intention isn't necessarily to merge the whole debugger, but what
we desire is to merge everything to allow the debugger to be built
outside of the tree (perhaps as a standalong module).

Jan
