Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269415AbUI3T2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269415AbUI3T2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269455AbUI3T2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:28:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:58801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269415AbUI3TZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:25:45 -0400
Date: Thu, 30 Sep 2004 12:23:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: colpatch@us.ibm.com
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       ak@suse.de
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
Message-Id: <20040930122312.3f09ed73.akpm@osdl.org>
In-Reply-To: <1096569412.20097.13.camel@arrakis>
References: <1096420339.15060.139.camel@arrakis>
	<415BC0BC.6040902@yahoo.com.au>
	<1096569412.20097.13.camel@arrakis>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> I would like to try to get this in before then, unless this will really
>  make things difficult for you.

It's about three weeks late for 2.6.9.  I already have a string of CPU
scheduler patches awaiting the 2.6.10 stream and once we're at -rc2 we
really should only be looking at bugfixes.

Grumble, mutter..  it looks like one of those "if it compiled, it works"
things.  Problem is, any time anyone touches that particular piece of the
kernel, half the architectures stop compiing.

