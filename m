Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbTCICIU>; Sat, 8 Mar 2003 21:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbTCICIU>; Sat, 8 Mar 2003 21:08:20 -0500
Received: from franka.aracnet.com ([216.99.193.44]:12256 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262357AbTCICIT>; Sat, 8 Mar 2003 21:08:19 -0500
Date: Sat, 08 Mar 2003 18:18:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Love <rml@tech9.net>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch] updated scheduler-tunables for 2.5.64-mm2
Message-ID: <477140000.1047176330@[10.10.2.4]>
In-Reply-To: <1047174868.719.7.camel@phantasy.awol.org>
References: <20030307185116.0c53e442.akpm@digeo.com> <1047095088.727.5.camel@phantasy.awol.org> <400810000.1047147915@[10.10.2.4]> <1047174868.719.7.camel@phantasy.awol.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Cool ... do you want to add the other two NUMA parameters as well to
>> your stack? (the idle and busy rebalance rates). Here's what I had
>> before with those in.
> 
> Sure.
> 
> But at least in 2.5.64 and 2.5.64-mm3, I do not see those parameters. 
> There is no {IDLE|BUSY}_NODE_REBALANCE_TICK define.

Ooops. Sorry ... we have to merge Ingo's NUMA sched updates first ;-)
/me goes back to swinging about in his own tree ...

M.

