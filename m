Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVILOqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVILOqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVILOqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:46:23 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:48303 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751158AbVILOqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:46:20 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [PATCH - Resend] PNPACPI: only parse device that have CRS method
Date: Mon, 12 Sep 2005 08:39:27 -0600
User-Agent: KMail/1.8.1
Cc: acpi-devel@lists.sourceforge.net, Adam Belay <ambx1@neo.rr.com>,
       linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>,
       Andrew Morton <akpm@osdl.org>
References: <4324030F.3090406@free.fr>
In-Reply-To: <4324030F.3090406@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509120839.27115.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 September 2005 4:12 am, matthieu castet wrote:
> this patch blacklist device that don't have CRS method as there are
> useless for pnp layer as they don't provide any resource.
> 
> Please comment and consider for inclusion.

Looks reasonable to me.
