Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbTETK3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 06:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTETK3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 06:29:49 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:20209 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263687AbTETK3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 06:29:47 -0400
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
From: Martin Schlemmer <azarah@gentoo.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053427006.9152.397.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 20 May 2003 12:36:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 23:22, Nguyen, Tom L wrote:
> Here is a patch containing the vector-based indexing part only.
> 

Do not seem to patch even against 2.5.66 ...

> Thanks,
> Tom
> 
> 
> 
> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> Sent: Wednesday, May 14, 2003 12:54 PM
> To: Nakajima, Jun
> Cc: Nguyen, Tom L; linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick,
> Asit K; Carbonari, Steven
> Subject: RE: RFC Proposal to enable MSI support in Linux kernel
> 
> 
> On Wed, 14 May 2003, Nakajima, Jun wrote:
> 
> > That's a good idea, and that's the way we did this (we added MSI 
> > support on top of the vector-based indexing). If people are interested in 
> > the vector-based indexing (i.e. provide the vector number to device 
> > drivers (non-legacy drivers only) instead of IRQ) for some other uses, we 
> > would like to discuss possible cleaner implementations.
> > 
> > Long will post a patch containing the vector-based indexing part only. 
> 
> Thanks! It'd be a lot easier to test the core changes too. What do you 
> mean by non legacy?
> 
> 	Zwane
-- 
Martin Schlemmer


