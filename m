Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUJDPc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUJDPc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUJDPc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:32:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59370 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268207AbUJDPcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:32:54 -0400
Date: Mon, 4 Oct 2004 08:30:45 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: efocht@hpce.nec.com, akpm@osdl.org, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041004083045.1432f511.pj@sgi.com>
In-Reply-To: <842970000.1096901859@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<200410032221.26683.efocht@hpce.nec.com>
	<20041003134842.79270083.akpm@osdl.org>
	<200410041605.30395.efocht@hpce.nec.com>
	<842970000.1096901859@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> I don't think anyone is suggesting that either system as is could replace
> the other ...

I'm pretty sure Andrew was suggesting this.

He began this thread addressing me with the statement:
> 
> And CKRM is much more general than the cpu/memsets code, and hence it
> should be possible to realize your end-users requirements using an
> appropriately modified CKRM, and a suitable controller.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
