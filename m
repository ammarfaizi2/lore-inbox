Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbTFQPuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 11:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbTFQPuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 11:50:08 -0400
Received: from poup.poupinou.org ([195.101.94.96]:6959 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S264806AbTFQPuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 11:50:05 -0400
Date: Tue, 17 Jun 2003 18:03:15 +0200
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI broken... again!
Message-ID: <20030617160315.GA19560@poupinou.org>
References: <20030617144443.GA27558@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030617144443.GA27558@codeblau.de>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 04:44:43PM +0200, Felix von Leitner wrote:
> Linux 2.5.70 and above have broken ACPI.  Again.  This is my fifth
> machine on which I try ACPI, two notebooks and three desktops, chipsets
> from Intel, VIA and SiS, no matter, ACPI still breaks 'em all.
> 
> The symptom is that eth0 does not see the others.  /proc/interrupts has
> the correct interrupt listed, so it took me a while to suspect ACPI.
> agpgart also crashes, and firewire and USB didn't find any devices.
> 
> Why oh why is ACPI so horrendously broken?
> 
> And more to the point: if it _is_ this broken, why ship it at all?  I
> don't recall a single moment where ACPI did anything good for me, only
> crashes, data loss and general brokenness.  This may be a technology
> fitting Microsoft and Intel PCs, but why give it even more leverage by
> supporting it in Linux?  I say rip this abomination right out of the
> kernel and be done with it.
> 

Then how do you manage if one day you go with a64?
Do you have laptops with via chipsets?  If yes, do you
have overheat issues without acpi?  Ok, acpi is not stable for
you, but have you at least tryed a 2.4 kernels with
latest patches from sf.net/projects/acpi, or a 2.4 ac kernels?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
