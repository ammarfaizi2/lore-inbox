Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWHEBH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWHEBH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 21:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWHEBH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 21:07:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422687AbWHEBH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 21:07:58 -0400
Date: Fri, 4 Aug 2006 18:07:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: shaohua.li@intel.com, bjorn.helgaas@hp.com, len.brown@intel.com,
       linux-kernel@vger.kernel.org, ambx1@neo.rr.com, castet.matthieu@free.fr,
       linux-acpi@vger.kernel.org, uwe.bugla@gmx.de
Subject: Re: ACPIPNP and too large IO resources
Message-Id: <20060804180744.09213332.akpm@osdl.org>
In-Reply-To: <44D3E422.5060805@drzeus.cx>
References: <44AB608F.1060903@drzeus.cx>
	<200607051536.30771.bjorn.helgaas@hp.com>
	<20060705151803.5841e91d.akpm@osdl.org>
	<200607060929.04787.bjorn.helgaas@hp.com>
	<1152234189.21189.139.camel@sli10-desk.sh.intel.com>
	<44D3E422.5060805@drzeus.cx>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Aug 2006 02:19:46 +0200
Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> Shaohua Li wrote:
> > Sure. Please merge the patch Bjorn pointed out.
> >   
> 
> So? What's the status of this? Still not in Linus' tree.

We have an ack from Shaohua.  I'll merge it.
