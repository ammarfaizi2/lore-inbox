Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbUCTSto (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 13:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUCTSto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 13:49:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48088
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263506AbUCTStn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 13:49:43 -0500
Date: Sat, 20 Mar 2004 19:50:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040320185034.GE9009@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2696880000.1079800826@[10.10.2.4]> <20040320165500.GW9009@dualathlon.random> <2698500000.1079804017@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2698500000.1079804017@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, it crashed in the pfn_valid because NOPAGE_SIGBUS was returned,
so it was my mistake, will be correctd in -aa3.
