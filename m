Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUENKwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUENKwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 06:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUENKwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 06:52:49 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:31986 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265248AbUENKws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 06:52:48 -0400
Date: Fri, 14 May 2004 03:50:39 -0700
From: Paul Jackson <pj@sgi.com>
To: raghav@in.ibm.com
Cc: akpm@osdl.org, maneesh@in.ibm.com, dipankar@in.ibm.com, torvalds@osdl.org,
       manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040514035039.347871e8.pj@sgi.com>
In-Reply-To: <20040514103322.GA6474@in.ibm.com>
References: <409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<20040508201259.GA6383@in.ibm.com>
	<20041006125824.GE2004@in.ibm.com>
	<20040511132205.4b55292a.akpm@osdl.org>
	<20040514103322.GA6474@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like the new hashing function has brought down the performance.

"brought down the performance" as in "better, faster", right?

That is, your numbers show that the new hashing function is good, right?

Or do I have it backwards?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
