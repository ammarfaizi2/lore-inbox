Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTHWBdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTHWBdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:33:16 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:48287 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264393AbTHWBdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:33:02 -0400
Date: Fri, 22 Aug 2003 18:31:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: habanero@us.ibm.com, Nick Piggin <piggin@cyberone.com.au>,
       colpatch@us.ibm.com
cc: Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Message-ID: <1320000.1061602264@[10.10.2.4]>
In-Reply-To: <200308221912.38184.habanero@us.ibm.com>
References: <Pine.LNX.3.96.1030813163849.12417I-100000@gatekeeper.tmr.com> <200308221046.31662.habanero@us.ibm.com> <3F469FA4.6020203@cyberone.com.au> <200308221912.38184.habanero@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> node_2_node is an odd sounding conversion too ;)
> 
> I just went off the toplogy already there, so I left it.

I thought we changed that to parent_node or something a while back?
Yes, node_2_node is rather nondescriptive ... 

Matt?

M.
