Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265324AbTLRV0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbTLRV0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:26:34 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:16798 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265324AbTLRV0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:26:32 -0500
Date: Thu, 18 Dec 2003 13:25:52 -0800
To: Len Brown <len.brown@intel.com>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] [BKPATCH] ACPI update for 2.6
Message-ID: <20031218212552.GA956@sgi.com>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	ACPI Developers <acpi-devel@lists.sourceforge.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1071742310.2496.217.camel@dhcppc4> <20031218211213.GA845@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218211213.GA845@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

willy just pointed out that these patches should probably use pr_debug()
instead.  If you're ok with the idea, I can create a new patch.

Thanks,
Jesse

On Thu, Dec 18, 2003 at 01:12:13PM -0800, Jesse Barnes wrote:
> On Thu, Dec 18, 2003 at 05:11:50AM -0500, Len Brown wrote:
> > Hi Andrew/Linus, please do a 
> > 
> > 	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.6.0
> 
> Len, could you please include these two patches in your next update if
> you think they're ok?  They make the boot a lot quieter on big NUMA
> boxes...
> 
> Thanks,
> Jesse
