Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUCLCNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUCLCNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:13:40 -0500
Received: from dp.samba.org ([66.70.73.150]:39298 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261904AbUCLCNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:13:39 -0500
Date: Fri, 12 Mar 2004 13:12:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040312021259.GG16751@krispykreme>
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311134955.GB16751@krispykreme> <4050F657.3050005@cyberone.com.au> <40511A89.3040204@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40511A89.3040204@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You need to be setting cpu_power for each of the CPU groups.

Aha, thanks. I'll do that and retest.

Anton
