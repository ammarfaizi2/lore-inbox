Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWCRTzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWCRTzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 14:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWCRTzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 14:55:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbWCRTyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 14:54:52 -0500
Date: Sat, 18 Mar 2006 11:51:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, matthew.e.tolentino@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Message-Id: <20060318115148.06d5a6e9.akpm@osdl.org>
In-Reply-To: <20060318154319.GB29862@humbolt.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com>
	<20060106172140.GB19605@lists.us.dell.com>
	<20060106223932.GB9230@lists.us.dell.com>
	<20060317155445.602f07b9.akpm@osdl.org>
	<20060318145621.GA29862@humbolt.us.dell.com>
	<20060318154319.GB29862@humbolt.us.dell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch <Matt_Domsch@dell.com> wrote:
>
> > Built 2.6.16-rc6-mm2 on ia64 Itanium2 (Dell PowerEdge 7250, aka Intel
>  > Tiger4).  Compiled clean, loaded clean, works as expected.  Thanks!
> 
>  Built 2.6.16-rc6-mm2 on x86_64 Dell PowerEdge 2800.  Compiled clean,
>  loaded clean, works as expected.  Thanks!

Sweet, thanks.
