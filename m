Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVCRPBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVCRPBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVCRPBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:01:35 -0500
Received: from mail1.upco.es ([130.206.70.227]:59585 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261630AbVCRPBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:01:31 -0500
Date: Fri, 18 Mar 2005 16:01:29 +0100
From: Romano Giannetti <romanol@upco.es>
To: Len Brown <len.brown@intel.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [BKPATCH] ACPI for 2.6.12-rc1
Message-ID: <20050318150129.GB22887@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Len Brown <len.brown@intel.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <1111127024.9332.157.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1111127024.9332.157.camel@d845pe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 01:23:44AM -0500, Len Brown wrote:

> 	This includes the ACPI part of memory hotplug,
> 	plus various fixes, BIOS workarounds and a fix for
> 	an interpreter regressions we had in 2.6.11 vs 2.6.10.

Thank you for the grat work. Could I humble advocating pushing the patch 
http://bugme.osdl.org/attachment.cgi?id=4516&action=view ,please? It fixed a
very bad regression in hotkey event from 2.6.9...

Thanks!




-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
