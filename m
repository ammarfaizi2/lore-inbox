Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbUJ1Pwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUJ1Pwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUJ1Psm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:48:42 -0400
Received: from fsmlabs.com ([168.103.115.128]:41603 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261721AbUJ1PrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:47:15 -0400
Date: Thu, 28 Oct 2004 09:44:55 -0600 (MDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
In-Reply-To: <200410251731.11445.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0410280944120.9945@musoma.fsmlabs.com>
References: <200410222354.44563.rjw@sisk.pl> <200410251627.51939.rjw@sisk.pl>
 <Pine.LNX.4.61.0410251740060.3029@musoma.fsmlabs.com> <200410251731.11445.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Rafael J. Wysocki wrote:

> > Ok, perhaps you shouldn't thank me ;) I actually sortof kinda broke your 
> > box... The reason why it worked before was because the kernel defaulted to 
> > disabling the IOAPIC on all nforce3 based systems but we found out that 
> > most nforce3 systems are actually work with the IOAPIC if we just ignore 
> > some bogus ACPI BIOS information. Your system happens to be one of the 
> > more broken ones, i'd actually like to try debug your problem a bit 
> > further, could you open up a bugzilla entry at bugzilla.kernel.org and 
> > email me when you're done. In the meantime, just keep booting with 
> > 'noapic'
> 
> OK
> The bugzilla entry is at:
> http://bugzilla.kernel.org/show_bug.cgi?id=3639

Thanks Rafael,
	We'll work on it from there then.

	Zwane

