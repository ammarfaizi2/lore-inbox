Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWILNk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWILNk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 09:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWILNk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 09:40:57 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:8579 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030243AbWILNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 09:40:56 -0400
Date: Tue, 12 Sep 2006 14:40:50 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] - restore i8259A eoi status on resume
Message-ID: <20060912134050.GA31858@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <20060912091906.GB19482@elf.ucw.cz> <20060912124742.GB31344@srcf.ucam.org> <200609121411.36913.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609121411.36913.ak@suse.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 02:11:36PM +0200, Andi Kleen wrote:

> Yes. I already have it queued for .19 at least. Not sure it's critical enough 
> for .18, especially since it doesn't seem to be a regression.

Yeah, I'd tend to agree.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
