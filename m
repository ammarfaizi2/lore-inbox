Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUCKK1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 05:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUCKK1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 05:27:34 -0500
Received: from s4.uklinux.net ([80.84.72.14]:21711 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S261170AbUCKK1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 05:27:33 -0500
Date: Thu, 11 Mar 2004 10:27:43 +0000
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3: VIA+ACPI+yenta->hang
Message-ID: <20040311102743.GA2063@hindley.uklinux.net>
References: <A6974D8E5F98D511BB910002A50A6647615F4B49@hdsmsx402.hd.intel.com> <1078987693.2555.81.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078987693.2555.81.camel@dhcppc4>
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 01:48:13AM -0500, Len Brown wrote:
 
> Mark,
> Please test the patch here:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=1564
> 

Thanks. Unfortunately, still hangs at the same point. Any other
suggestions? Would ACPI_DEBUG be helpful?

Mark
