Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbWFVTxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWFVTxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWFVTxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:53:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:1665 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932646AbWFVTxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:53:40 -0400
Subject: Re: [Lse-tech] [PATCH 00/11] Task watchers:  Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Matt Helsley <matthltc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       LSE-Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <449A38BE.9070606@bigpond.net.au>
References: <1150242721.21787.138.camel@stark>
	 <4498DC23.2010400@bigpond.net.au> <1150876292.21787.911.camel@stark>
	 <44992EAA.6060805@bigpond.net.au> <44993079.40300@bigpond.net.au>
	 <1150925387.21787.1056.camel@stark> <4499D097.5030604@bigpond.net.au>
	 <1150936337.21787.1114.camel@stark> <4499EE29.9020703@bigpond.net.au>
	 <1150947965.21787.1228.camel@stark>  <449A1C0D.7030906@bigpond.net.au>
	 <1150954621.21787.1272.camel@stark>  <449A38BE.9070606@bigpond.net.au>
Content-Type: text/plain
Organization: IBM
Date: Thu, 22 Jun 2006 12:53:36 -0700
Message-Id: <1151006016.26136.16.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 16:29 +1000, Peter Williams wrote:

> Peter
> PS A year or so ago the CKRM folks promised to have a look at using PAGG 
> instead of inventing their own but I doubt that they ever did.

I think it was about 2 years back. We weren't going to re-invent after
that point, we had a full implementation at that time.

If i remember correct, we concluded that some design constraints and
additional overhead were the reasons for not proceeding in that
direction.

BTW, if i remember correct, PAGG folks also promised to look at CKRM to
see if they could use CKRM instead.

chandra
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


