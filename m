Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422846AbWCXN7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422846AbWCXN7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 08:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWCXN7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 08:59:18 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:10306 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1422846AbWCXN7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 08:59:17 -0500
X-IronPort-AV: i="4.03,126,1141624800"; 
   d="scan'208"; a="64993454:sNHT4826793050"
Date: Fri, 24 Mar 2006 07:59:14 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Increment IPMI driver version to v39.0
Message-ID: <20060324135914.GA1030@lists.us.dell.com>
References: <20060324135451.GA7557@i2.minyard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324135451.GA7557@i2.minyard.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 07:54:51AM -0600, Corey Minyard wrote:
> 
> Need to increment the version number because of the new PCI and
> sysfs capabilities of the driver.  People maintaining things for
> distros have asked that I do this after interface or major
> functional changes.

Yes please.
 
> Signed-off-by: Corey Minyard <minyard@acm.org>

Acked-by: Matt Domsch <Matt_Domsch@dell.com>


-Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
