Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUJATfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUJATfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUJATeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:34:10 -0400
Received: from colin2.muc.de ([193.149.48.15]:8979 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266236AbUJATba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:31:30 -0400
Date: 1 Oct 2004 21:31:28 +0200
Date: Fri, 1 Oct 2004 21:31:28 +0200
From: Andi Kleen <ak@muc.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Suresh Siddha <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [Patch 1/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525 - change TARGET_CPUS on x86_64
Message-ID: <20041001193128.GA47295@muc.de>
References: <2HSdY-7dr-3@gated-at.bofh.it> <20040930230133.0d4bcc0d.akpm@osdl.org> <20041001071922.GA32950@muc.de> <200410011202.41048.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410011202.41048.jamesclv@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Excuse me, but since when is February "far off pie in the sky for some 
> future unreleased hardware"?

Compared to currently shipping Intel chipsets it definitely is. 

> Zeus boxes are going out the door 1Q2005.  The question is, will v2.6 
> work on them or not?

It will at some point, after the intrusive patches needed to support
their pecularities have been well enough tested. 

-Andi

