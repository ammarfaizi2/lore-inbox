Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWIUAb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWIUAb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWIUAb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:31:59 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:61379 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750829AbWIUAb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:31:58 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: npiggin@suse.de, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       Rohit Seth <rohitseth@google.com>, devel@openvz.org
In-Reply-To: <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 17:31:55 -0700
Message-Id: <1158798715.6536.115.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 12:52 -0700, Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Chandra Seetharaman wrote:
> 
> > cpuset partitions resource and hence the resource that are assigned to a
> > node is not available for other cpuset, which is not good for "resource
> > management".
> 
> cpusets can have one node in multiple cpusets.

AFAICS, That doesn't help me in over committing resources.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


