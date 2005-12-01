Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVLARtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVLARtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVLARtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:49:03 -0500
Received: from cantor.suse.de ([195.135.220.2]:15248 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932368AbVLARtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:49:02 -0500
Date: Thu, 1 Dec 2005 18:49:01 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Dugger, Donald D" <donald.d.dugger@intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, "Shah, Rajesh" <rajesh.shah@intel.com>,
       akpm@osdl.org
Subject: Re: Add VT flag to cpuinfo; SSE3 flag
Message-ID: <20051201174901.GL19515@wotan.suse.de>
References: <7F740D512C7C1046AB53446D372001730615842C@scsmsx402.amr.corp.intel.com> <Pine.LNX.4.61.0512011837470.28511@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512011837470.28511@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh BTW, I am missing an 'sse3' flag in /proc/cpuinfo on Opterons (running 
> 2.6.13). Could this be added, if it has not yet in 2.6.15rc*?

It's pni for historical reasons.

-Andi
