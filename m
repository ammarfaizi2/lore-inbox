Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbVHZSCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVHZSCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVHZSCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:02:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62632 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965153AbVHZSCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:02:10 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125077594.18155.52.camel@betsy>
References: <1125069494.18155.27.camel@betsy>
	 <430F5257.4010700@didntduck.org>  <1125077594.18155.52.camel@betsy>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 20:01:51 +0200
Message-Id: <1125079311.4294.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 13:33 -0400, Robert Love wrote:
> On Fri, 2005-08-26 at 13:33 -0400, Brian Gerst wrote:
> 
> > Is there any way to detect that this device is present (PCI, ACPI, etc.) 
> > without poking at ports?
> 
> Not that we've been able to tell.  It is a legacy platform device.
> 
> So, unfortunately, no probe() routine.

dmi surely....


