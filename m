Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUHWXWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUHWXWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268277AbUHWXQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:16:21 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:13528 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268275AbUHWXOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:14:43 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: kernbench on 512p
Date: Mon, 23 Aug 2004 16:13:47 -0700
User-Agent: KMail/1.6.2
Cc: paulmck@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
References: <200408191216.33667.jbarnes@engr.sgi.com> <41265CCE.3070808@colorfullife.com> <200408231423.11492.jbarnes@engr.sgi.com>
In-Reply-To: <200408231423.11492.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408231613.47095.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2004 2:23 pm, Jesse Barnes wrote:
> I haven't been able to boot successfully with this patch applied.  Things
> seem to get real slow around the time init starts, and the system becomes
> unusable.  I applied them on top of stock 2.6.8.1-mm4, which boots fine
> without them (testing that again to make sure, but I booted it a few times
> this morning w/o incident).

Disregard this.  My hardware appears broken, so I can't be sure what's going 
on.  Ugg.

Jesse
