Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVBHQSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVBHQSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVBHQST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:18:19 -0500
Received: from jade.aracnet.com ([216.99.193.136]:38560 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261559AbVBHQQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:16:02 -0500
Date: Tue, 08 Feb 2005 08:15:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Andi Kleen <ak@suse.de>, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <44870000.1107879300@[10.10.2.4]>
In-Reply-To: <420800F5.9070504@us.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>	 <20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]>	 <200408061730.06175.efocht@hpce.nec.com>	<20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>	<20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com>	<20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com>	<415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]>	 <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <420800F5.9070504@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry to reply a long quiet thread, but I've been trading emails with 
> Paul Jackson on this subject recently, and I've been unable to convince 
> either him or myself that merging CPUSETs and CKRM is as easy as I once 
> believed.  I'm still convinced the CPU side is doable, but I haven't 
> managed as much success with the memory binding side of CPUSETs.  

Can you describe what the difficulty is with the mem binding side?

Thanks,

M.

PS. If you could also make your mailer line-wrap, that'd be splendid ;-)

