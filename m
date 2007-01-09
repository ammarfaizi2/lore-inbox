Return-Path: <linux-kernel-owner+w=401wt.eu-S1750896AbXAITLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXAITLN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXAITLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:11:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:21749 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbXAITLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:11:12 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="183208846:sNHT1752285773"
Message-ID: <45A3E8BF.8080401@intel.com>
Date: Tue, 09 Jan 2007 11:10:55 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Auke Kok <auke-jan.h.kok@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH -MM] e1000: rewrite hardware initialization code
References: <45A3D29D.1000202@intel.com> <20070109104525.b0f17316.akpm@osdl.org>
In-Reply-To: <20070109104525.b0f17316.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2007 19:10:56.0137 (UTC) FILETIME=[E3A84790:01C73421]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 09 Jan 2007 09:36:29 -0800
> Auke Kok <auke-jan.h.kok@intel.com> wrote:
> 
>>      git-pull git://lost.foo-projects.org/~ahkok/git/linux-2.6 e1000
> 
> That tree appears to be based on the -mm git tree?
> 
> That's a somewhat unusual thing to do - a tree which is based on current
> Linus mainline would be preferred, please.  Or on Jeff's netdev tree.

those are not in sync atm, but I'll get you one against Jeff's upstream tree, that'll 
take a minute, or five.

Auke
