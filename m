Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTENTum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTENTum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:50:42 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:32385
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261161AbTENTul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:50:41 -0400
Date: Wed, 14 May 2003 15:54:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "" <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB56401E451D2@fmsmsx407.fm.intel.com>
Message-ID: <Pine.LNX.4.50.0305141552390.15555-100000@montezuma.mastecende.com>
References: <3014AAAC8E0930438FD38EBF6DCEB56401E451D2@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Nakajima, Jun wrote:

> That's a good idea, and that's the way we did this (we added MSI 
> support on top of the vector-based indexing). If people are interested in 
> the vector-based indexing (i.e. provide the vector number to device 
> drivers (non-legacy drivers only) instead of IRQ) for some other uses, we 
> would like to discuss possible cleaner implementations.
> 
> Long will post a patch containing the vector-based indexing part only. 

Thanks! It'd be a lot easier to test the core changes too. What do you 
mean by non legacy?

	Zwane
-- 
function.linuxpower.ca
