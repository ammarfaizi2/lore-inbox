Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268485AbUHLAco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268485AbUHLAco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUHLAaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:30:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:487 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268308AbUHLAES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:04:18 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Linh Dang <linhd@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <wn51xid99qf.fsf@linhd-2.ca.nortel.com>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe>
	 <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu>
	 <1092210765.1650.3.camel@mindpipe> <20040811082712.GB6528@elte.hu>
	 <wn51xid99qf.fsf@linhd-2.ca.nortel.com>
Content-Type: text/plain
Message-Id: <1092269085.1090.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 20:04:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 07:48, Linh Dang wrote:
> Hi,
> 
> I'm not running the voluntary-preempt-* patches. but I do see some
> long latencies with:
> 
>         vanilla 2.6.7+preempt-timing+defer-softirq
> 
> which were NOT reported here. Is it useful the report them?
> 

Probably not.  Many latency issues as well as bugs in the preempt timing
patch have been fixed since then.  You should try the latest version.

Lee

