Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVHIPdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVHIPdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVHIPdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:33:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30455 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964824AbVHIPdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:33:21 -0400
Subject: Re: Soft lockup in e100 driver ?
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1123601029.18332.162.camel@localhost.localdomain>
References: <20050809133647.GK22165@mea-ext.zmailer.org>
	 <1123599524.30101.7.camel@mindpipe>
	 <1123601029.18332.162.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 08:32:50 -0700
Message-Id: <1123601576.15991.29.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 11:23 -0400, Steven Rostedt wrote:
> 
> I just downloaded 2.6.13-rc6-git and I don't see the merge of the soft
> lockup code.  Is this a Fedora thing?  If so, could someone point me to
> a link to download this Fedora kernel. I'm currently using Debian.

I seem to recall seeing fedora using voluntary preempt before it was
merged.

Daniel

