Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUAWHC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265708AbUAWHCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:02:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:29674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266525AbUAWHBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:01:54 -0500
Date: Thu, 22 Jan 2004 23:02:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org, nevdull@us.ibm.com,
       dvhart@us.ibm.com
Subject: Re: [PATCH] clarify find_busiest_group
Message-Id: <20040122230237.252c4dbe.akpm@osdl.org>
In-Reply-To: <4010C2BF.7090806@cyberone.com.au>
References: <224300000.1074839500@[10.10.2.4]>
	<4010C2BF.7090806@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Andrew would you like me to take small changes like this and
>  feed them to you, or are you happy enough to pick them up?

I scooped that one up.  The main outstanding thing is Rusty's largeish
patch.

<looks>

Time for -mm2, methinks.
