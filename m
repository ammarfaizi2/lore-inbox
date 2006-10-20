Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWJTAi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWJTAi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWJTAi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:38:58 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:1284 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751631AbWJTAi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:38:58 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=AxNh2thhIbOPrC1K99iXGJ/ev9zCpwa/TSajmxCgthLtYcwyqDZY6namlLS0SAApYvu2vCYtmTbNqj4sDGm4wC8gbXMngHHz9o4Aga7bk9hEdGsOcEF6DdDhkbd1CWwg;
X-IronPort-AV: i="4.09,331,1157346000"; 
   d="scan'208"; a="100438009:sNHT23348943"
Date: Thu, 19 Oct 2006 19:38:59 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Joshua Schmidlkofer <joshua@imrlive.com>
Cc: Joshua Schmidlkofer <jms@dev.imr-net.com>, linux-kernel@vger.kernel.org,
       Mike Montagne <mike@opsisarch.com>
Subject: Re: Recurring MegaRAID SCSI Errors
Message-ID: <20061020003859.GA26880@lists.us.dell.com>
References: <4537F7AA.4060709@imr-net.com> <20061019222633.GC7410@lists.us.dell.com> <4537FE1C.2060508@imr-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4537FE1C.2060508@imr-net.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 03:37:16PM -0700, Joshua Schmidlkofer wrote:
> 
> >Most likely you need this patch:
> >http://marc.theaimsgroup.com/?l=linux-scsi&m=115992186113515&w=2
> 
> Thanks for the reply.  Will this patch affect the non-SAS controllers?  
> My PERC4/DC is SCSI and not SAS.

d'oh.  Indeed, I mis-read your original note, and no, the above won't
help.

I now return you to you regularly scheduled plea.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
