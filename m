Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVC2Xch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVC2Xch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVC2Xch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:32:37 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:53634 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261645AbVC2Xcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:32:36 -0500
Subject: Re: NFS client latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112138283.11346.2.camel@lade.trondhjem.org>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 18:32:35 -0500
Message-Id: <1112139155.5386.35.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 18:18 -0500, Trond Myklebust wrote:
> ty den 29.03.2005 Klokka 18:04 (-0500) skreiv Lee Revell:
> > I am seeing long latencies in the NFS client code.  Attached is a ~1.9
> > ms latency trace.
> 
> What kind of workload are you using to produce these numbers?
> 

Just a kernel compile over NFS.

Lee

