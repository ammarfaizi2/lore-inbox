Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVK2XSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVK2XSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVK2XSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:18:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:42965 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751229AbVK2XSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:18:48 -0500
Date: Wed, 30 Nov 2005 00:18:46 +0100
From: Andi Kleen <ak@suse.de>
To: David Gibson <david@gibson.dropbear.id.au>, Andi Kleen <ak@suse.de>,
       Nicholas Miell <nmiell@comcast.net>,
       Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129231846.GV19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy> <20051129224346.GS19515@wotan.suse.de> <20051129230704.GA9659@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129230704.GA9659@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It need not necessarily remain configurable to be in PMC 0 however.
> Nor do the the PMC MSRs have to remain fixed..

If all fails the kernel can always trap and emulate it. But I hope this will 
never be needed.

-Andi
