Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVBHAQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVBHAQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 19:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVBHAQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 19:16:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:42139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261351AbVBHAQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 19:16:15 -0500
Date: Mon, 7 Feb 2005 16:20:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: mbligh@aracnet.com, pj@sgi.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20050207162024.23380cd6.akpm@osdl.org>
In-Reply-To: <420800F5.9070504@us.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
	<420800F5.9070504@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> Sorry to reply a long quiet thread,

Is appreciated, thanks.

> but I've been trading emails with Paul 
> Jackson on this subject recently, and I've been unable to convince either him 
> or myself that merging CPUSETs and CKRM is as easy as I once believed.  I'm 
> still convinced the CPU side is doable, but I haven't managed as much success 
> with the memory binding side of CPUSETs.  In light of this, I'd like to remove 
> my previous objections to CPUSETs moving forward.  If others still have things 
> they want discussed before CPUSETs moves into mainline, that's fine, but it 
> seems to me that CPUSETs offer legitimate functionality and that the code has 
> certainly "done its time" in -mm to convince me it's stable and usable.

OK, I'll add cpusets to the 2.6.12 queue.

going once, going twice...
