Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbUKKTT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbUKKTT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 14:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbUKKTT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 14:19:56 -0500
Received: from fmr06.intel.com ([134.134.136.7]:49887 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262317AbUKKTT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 14:19:29 -0500
Subject: Re: [ACPI] [2.6 patch] drivers/acpi: #ifdef unused functions away
From: Len Brown <len.brown@intel.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@stusta.de>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041111160842.GD1108@parcelfarce.linux.theplanet.co.uk>
References: <20041106114844.GK1295@stusta.de>
	 <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de>
	 <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe>
	 <20041110012134.GB4089@stusta.de>
	 <20041111151727.GB1108@parcelfarce.linux.theplanet.co.uk>
	 <20041111153650.GD8417@stusta.de>
	 <20041111154017.GC1108@parcelfarce.linux.theplanet.co.uk>
	 <20041111154656.GE8417@stusta.de>
	 <20041111160842.GD1108@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1100200668.5517.707.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Nov 2004 14:17:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 11:08, Matthew Wilcox wrote:
> On Thu, Nov 11, 2004 at 04:46:56PM +0100, Adrian Bunk wrote:

> > If yes, I will correct the acpi_remove_gpe_block case (it's only
> this
> > one function?) as soon as his tree appears in the next -mm.
> 
> acpi_remove_gpe_block and acpi_install_gpe_block.

No problem, both of these patches are on my list for today and I'll fix
this minor conflict.

thanks,
-Len



