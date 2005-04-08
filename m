Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVDHVvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVDHVvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVDHVvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 17:51:39 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41663 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261157AbVDHVve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 17:51:34 -0400
Subject: Re: 'BUG: scheduling with irqs disabled' when umounting NFS volume
From: Lee Revell <rlrevell@joe-job.com>
To: dwalker@mvista.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <1112992701.26296.16.camel@dhcp153.mvista.com>
References: <1112991311.11000.37.camel@mindpipe>
	 <1112992701.26296.16.camel@dhcp153.mvista.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 17:51:33 -0400
Message-Id: <1112997093.12195.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 13:38 -0700, Daniel Walker wrote:
> I submitted a fix for this a while ago, I think ..
> interruptible_sleep_on()'s are broken .. 

I saw the fix in -stable, but it does not seem to be in 2.6.12-rc2.

Lee

