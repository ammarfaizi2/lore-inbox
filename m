Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUHBH5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUHBH5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 03:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUHBH5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 03:57:35 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17900 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266347AbUHBH51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 03:57:27 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040802073938.GA8332@elte.hu>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe> <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe>
	 <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
	 <1091403477.862.4.camel@mindpipe> <1091407585.862.40.camel@mindpipe>
	 <20040802073938.GA8332@elte.hu>
Content-Type: text/plain
Message-Id: <1091433481.3024.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 03:58:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 03:39, Ingo Molnar wrote:

> btw., with what max_sectors setting were you testing during these tests? 
> In -O2 the hardirqs are not preemptable (yet) so with 1024 sectors you
> should see quite high latencies due to the completion activity.

256.  It will be a few days before I can do any more testing.

Lee

