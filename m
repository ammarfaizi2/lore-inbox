Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUJDPoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUJDPoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUJDPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:44:10 -0400
Received: from jade.aracnet.com ([216.99.193.136]:62431 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268253AbUJDPnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:43:09 -0400
Date: Mon, 04 Oct 2004 08:41:45 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: efocht@hpce.nec.com, akpm@osdl.org, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <850440000.1096904504@[10.10.2.4]>
In-Reply-To: <20041004083045.1432f511.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><200410032221.26683.efocht@hpce.nec.com><20041003134842.79270083.akpm@osdl.org><200410041605.30395.efocht@hpce.nec.com><842970000.1096901859@[10.10.2.4]> <20041004083045.1432f511.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin wrote:
>> I don't think anyone is suggesting that either system as is could replace
>> the other ...
> 
> I'm pretty sure Andrew was suggesting this.
> 
> He began this thread addressing me with the statement:
>> 
>> And CKRM is much more general than the cpu/memsets code, and hence it
>> should be possible to realize your end-users requirements using an

Note especially the last line:

>> appropriately modified CKRM, and a suitable controller.

So not CKRM as-is ...

M.

