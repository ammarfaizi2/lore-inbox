Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUAUCBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 21:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUAUCBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 21:01:49 -0500
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:42378 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S265812AbUAUCBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 21:01:48 -0500
From: jlnance@unity.ncsu.edu
Date: Tue, 20 Jan 2004 21:01:34 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chris.Petersen@synopsys.com, jlnance@unity.ncsu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Awful NFS performance with attached test program
Message-ID: <20040121020134.GA4577@ncsu.edu>
References: <20040119211649.GA20200@ncsu.edu> <1074549226.1560.59.camel@nidelv.trondhjem.org> <20040120132803.GA2830@ncsu.edu> <1074607946.1871.37.camel@nidelv.trondhjem.org> <400D897C.A5439DFE@synopsys.com> <1074635444.5368.286.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074635444.5368.286.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 04:50:44PM -0500, Trond Myklebust wrote:

> Surprise! Linux and Solaris show exactly the same behaviour.
> 
> As I said before in 2.4.x we have a hard limit of 256 outstanding
> requests before we have to wait on requests to complete. Remove that
> limit, and all is well...

Nice job with the 2.6 performance!  Im looking forward to the day when
distributors start shipping it.

Thanks,

Jim
