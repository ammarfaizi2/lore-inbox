Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTE1Xrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTE1Xrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:47:32 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:56707
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261780AbTE1Xr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:47:29 -0400
Date: Wed, 28 May 2003 19:50:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "" <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: Re: RFC Proposal to enable MSI support in Linux kernel
In-Reply-To: <3ED54A24.5010102@pobox.com>
Message-ID: <Pine.LNX.4.50.0305281948030.4964-100000@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com>
 <Pine.LNX.4.50.0305201447460.20429-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0305281650110.4964-100000@montezuma.mastecende.com>
 <3ED53FE3.8090503@pobox.com> <Pine.LNX.4.50.0305281854180.4964-100000@montezuma.mastecende.com>
 <3ED54A24.5010102@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Jeff Garzik wrote:

> Have you ever seen an edge-triggered interrupt on x86 that would fail 
> the current platform_legacy_irq test?  For what cases does that happen? 
>   The legacy interrupts on the boxes I poked at are edge triggered, but 
> I do not know enough to say if that is a general rule.

I second that, i haven't seen such a system. Perhaps the intel guys have?

	Zwane
-- 
function.linuxpower.ca
