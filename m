Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVAXQVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVAXQVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVAXQVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:21:38 -0500
Received: from ns.suse.de ([195.135.220.2]:8391 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261232AbVAXQVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:21:37 -0500
Date: Mon, 24 Jan 2005 17:21:36 +0100
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andi Kleen <ak@suse.de>, Anton Blanchard <anton@samba.org>, akpm@osdl.org,
       paulus@samba.org, tony.luck@intel.com, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Problems disabling SYSCTL
Message-ID: <20050124162136.GE29950@wotan.suse.de>
References: <20050123050102.GD5920@krispykreme.ozlabs.ibm.com> <20050123143500.GC31455@parcelfarce.linux.theplanet.co.uk> <20050123191743.GB6784@wotan.suse.de> <20050124135001.GC27258@krispykreme.ozlabs.ibm.com> <20050124160053.GB29950@wotan.suse.de> <20050124161456.GK31455@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124161456.GK31455@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How are kernel hackers to know it's been deprecated?  ;-)

Good idea, yes.

-Andi
