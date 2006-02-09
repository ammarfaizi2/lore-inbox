Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWBIGEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWBIGEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWBIGEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:04:10 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2529 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422802AbWBIGEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:04:09 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139395534.21471.13.camel@frecb000686>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <1139395534.21471.13.camel@frecb000686>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 09 Feb 2006 01:04:05 -0500
Message-Id: <1139465045.30058.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 11:45 +0100, Sébastien Dugué wrote:
> The more I think about it, the more I tend to believe it's hardware 
> related. It seems as if the CPU just hangs for ~27 ms before
> resuming processing. 

That would be an exceptionally long latency - you would probably notice
it if the mouse froze, VOIP dropped out, ping stops, etc for 30ms.

Lee

