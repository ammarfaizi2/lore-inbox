Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVAEWi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVAEWi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 17:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVAEWi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 17:38:27 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29641 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262625AbVAEWiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 17:38:24 -0500
Subject: Re: 2.6.10-mm1
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200501030917.20414.jbarnes@engr.sgi.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
	 <200501030917.20414.jbarnes@engr.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1104964701.17541.18.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 05 Jan 2005 14:38:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 09:17, Jesse Barnes wrote:
> On Monday, January 3, 2005 1:11 am, you wrote:
> > +replace-numnodes-with-node_online_map-ia64.patch
> 
> Here are some compile fixes for this patch.  Looks like simple typos.  Note 
> that the kernel won't boot even with these fixes, I'm debugging that now 
> (suspect nodemask related stuff is causing the hang too).
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> 
> Jesse

Those 2 fixes look good.  Thanks for the catch, Jesse!

-Matt

