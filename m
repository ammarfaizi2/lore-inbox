Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbTCIBnr>; Sat, 8 Mar 2003 20:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbTCIBnr>; Sat, 8 Mar 2003 20:43:47 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:40713
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262335AbTCIBnq>; Sat, 8 Mar 2003 20:43:46 -0500
Subject: Re: [patch] updated scheduler-tunables for 2.5.64-mm2
From: Robert Love <rml@tech9.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <400810000.1047147915@[10.10.2.4]>
References: <20030307185116.0c53e442.akpm@digeo.com>
	 <1047095088.727.5.camel@phantasy.awol.org>
	 <400810000.1047147915@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1047174868.719.7.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 08 Mar 2003 20:54:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 13:25, Martin J. Bligh wrote:

> Cool ... do you want to add the other two NUMA parameters as well to
> your stack? (the idle and busy rebalance rates). Here's what I had
> before with those in.

Sure.

But at least in 2.5.64 and 2.5.64-mm3, I do not see those parameters. 
There is no {IDLE|BUSY}_NODE_REBALANCE_TICK define.

	Robert Love

