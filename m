Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTJXSmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTJXSmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:42:20 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:62917 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262454AbTJXSmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:42:18 -0400
Date: Fri, 24 Oct 2003 20:38:52 +0200
From: Dominik Brodowski <linux@brodo.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Moore, Robert" <robert.moore@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       linux-acpi <linux-acpi@intel.com>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031024183852.GE28421@brodo.de>
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com> <20031023141703.GG643@openzaurus.ucw.cz> <CFF522B18982EA4481D3A3E23B83141C24B4DF@orsmsx407.jf.intel.com> <7F740D512C7C1046AB53446D3720017304B04F@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031023141703.GG643@openzaurus.ucw.cz> <CFF522B18982EA4481D3A3E23B83141C24B4DF@orsmsx407.jf.intel.com> <7F740D512C7C1046AB53446D3720017304B04F@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vetoed.

cpufreq_dynamic is too generic, there are different approaches == different
governors in the work which are all "dynamic".

	Dominik

On Thu, Oct 23, 2003 at 02:50:06PM -0700, Nakajima, Jun wrote:
> Me too, because it would be consistent with the other ones; i.e. how the
> user perceives them.

On Thu, Oct 23, 2003 at 01:47:49PM -0700, Moore, Robert wrote:
> 
> I would vote for "cpufreq_dynamic"
> 
> Bob

On Thu, Oct 23, 2003 at 04:17:04PM +0200, Pavel Machek wrote:
> Could you name it cpufreq_demand? We have enough
> TLAs as is.
> 				Pavwl

