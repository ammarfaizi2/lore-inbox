Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbVHZWnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbVHZWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 18:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVHZWnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 18:43:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:30098 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751605AbVHZWnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 18:43:24 -0400
To: Robert Love <rml@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
References: <1125069494.18155.27.camel@betsy> <430F5257.4010700@didntduck.org>
	<1125077594.18155.52.camel@betsy>
	<1125079311.4294.10.camel@laptopd505.fenrus.org>
	<1125079430.18155.64.camel@betsy>
	<1125086134.14080.13.camel@localhost.localdomain>
	<1125084555.18155.89.camel@betsy> <430F6E6F.5010001@pobox.com>
	<1125085037.18155.95.camel@betsy>
From: Andi Kleen <ak@suse.de>
Date: 27 Aug 2005 00:43:22 +0200
In-Reply-To: <1125085037.18155.95.camel@betsy>
Message-ID: <p734q9cmi9h.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> writes:

> On Fri, 2005-08-26 at 15:33 -0400, Jeff Garzik wrote:
> 
> > Since such a check is possible, that's definitely a merge-stopper IMO
> 
> First, I am not asking that Linus merge this.  Everyone needs to relax.
> 
> Second, we don't know a DMI-based solution will work. I'll check it out.

With some luck it might be in the ACPI name space with a known
name. If yes that would be far more reliable than DMI.

-Andi
