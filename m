Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWIAEWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWIAEWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWIAEWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:22:12 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:12805 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932076AbWIAEWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:22:10 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=YNwXE+SDHgX0am3G1Eaei2dj8TjGtuLICu7sZdHDbOeUEMabgolanN6cbWbl0cKx+lCx0LbXOu/prWoEaWHXfYxHVuF0d41/C0twnVZLafwrO02de8kXuSI4HsFCC0gw;
X-IronPort-AV: i="4.08,196,1154926800"; 
   d="scan'208"; a="72630561:sNHT28164024"
Date: Thu, 31 Aug 2006 23:22:13 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Dapid Candra <dapidc@cbn.net.id>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help in kernel error
Message-ID: <20060901042213.GC6884@lists.us.dell.com>
References: <1816.202.171.0.72.1157083717.CBNWebMail@webmail2.cbn.net.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1816.202.171.0.72.1157083717.CBNWebMail@webmail2.cbn.net.id>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 11:08:37AM +0700, Dapid Candra wrote:
> Hi,
> 
> I got the following messages just before my server freeze.
> 
> The server is now served as Oracle database server. It is also using
> external storage connected by SCSI. It runs Red Hat EL AS 4.0. And it has
> 4GB RAM.

> Aug 31 23:02:27 hqdmsdb01 kernel: EFLAGS: 00010246   (2.6.9-5.ELsmp)

You need to take this up with either your system hardware vendor's
support department, or with Red Hat support directly.  Upgrading to a
more recent kernel from RHN may well alleviate this too.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
