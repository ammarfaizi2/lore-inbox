Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTFXLMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 07:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTFXLMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 07:12:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47255 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261944AbTFXLMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 07:12:22 -0400
Date: Tue, 24 Jun 2003 12:26:30 +0100
From: Matthew Wilcox <willy@debian.org>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Message-ID: <20030624112630.GB451@parcelfarce.linux.theplanet.co.uk>
References: <20030623221541.GA8096@alf.amelek.gda.pl> <20030623222311.GD25982@parcelfarce.linux.theplanet.co.uk> <20030624054612.GA20235@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624054612.GA20235@alf.amelek.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 07:46:12AM +0200, Marek Michalkiewicz wrote:
> On Mon, Jun 23, 2003 at 11:23:11PM +0100, Matthew Wilcox wrote:
> > Have you patched 2.4.21 with the latest ACPI patch, or is this vanilla
> > 2.4.21?
> 
> Vanilla 2.4.21 - tried 2.4.21-ac1 once, but it said Oops at boot time
> (something about the VIA686A sound driver - not related to ACPI).

The ACPI code in 2.4.21 is something like 18 months old now.  It's
basically unmaintainable.  Fortunately, 2.4.22 should have an ACPI update.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
