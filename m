Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVCRACh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVCRACh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVCRACg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:02:36 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:16816 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261292AbVCRACa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:02:30 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Nate Lawson <nate@root.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <4239E9BA.7050105@root.org>
References: <1110741241.8136.46.camel@tyrosine>  <423518E7.3030300@root.org>
	 <1111072221.8136.171.camel@tyrosine>  <4239E9BA.7050105@root.org>
Date: Fri, 18 Mar 2005 00:02:34 +0000
Message-Id: <1111104154.8136.179.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] IDE failure on ACPI resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 12:34 -0800, Nate Lawson wrote:

> Very interesting.  I was hoping to someday have _GTF et al implemented 
> but the ATA knowledge required was above my head.  I also strongly 
> suspected that the info published by _GTF would likely be invalid.  Does 
> Windows actually use that method or just hardcoded ATA initialization?

I believe that Windows does use the _GTF methods.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

