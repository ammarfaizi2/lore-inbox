Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTJNWbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 18:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTJNWbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 18:31:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:38578 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262011AbTJNWbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 18:31:00 -0400
Date: Tue, 14 Oct 2003 15:30:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "M. Fioretti" <m.fioretti@inwind.it>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: wli <wli@holomorphy.com>
Subject: Re: Unbloating the kernel, action list
Message-ID: <16710000.1066170641@flay>
In-Reply-To: <20031014214311.GC933@inwind.it>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 7) Do come in suggesting anything I might have forgotten

If you do automated testing of nightly builds of the mainline 2.6 / 2.7
kernels, and point out when they get bigger in consumption, you'll have
a much better chance of convincing people to fix it when the patch in
question is still topical, and fresh in people's minds.

I'd predict that a lot of the issue is just tuning things dynamically 
instead of statically sizing them.

M.

