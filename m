Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUJBXbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUJBXbt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 19:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUJBXbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 19:31:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37528 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267601AbUJBXbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 19:31:42 -0400
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
	memory placement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, mef@CS.Princeton.EDU, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, pj@sgi.com, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com,
       llp@CS.Princeton.EDU
In-Reply-To: <415F34FF.8040806@watson.ibm.com>
References: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
	 <415ED4A4.1090001@watson.ibm.com> <20041002134059.65b45e29.akpm@osdl.org>
	 <415F34FF.8040806@watson.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096755956.25897.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 02 Oct 2004 23:26:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-03 at 00:08, Hubertus Franke wrote:
> Andrew Morton wrote:
> > Hubertus Franke <frankeh@watson.ibm.com> wrote:
> > 
> >>Marc, cpusets lead to physical isolation.

Not realistically on x86 unless you start billing memory accesses IMHO

