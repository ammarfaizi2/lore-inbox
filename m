Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbTFXFcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 01:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbTFXFcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 01:32:09 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:65295 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S265697AbTFXFcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 01:32:08 -0400
Date: Tue, 24 Jun 2003 07:46:12 +0200
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Message-ID: <20030624054612.GA20235@alf.amelek.gda.pl>
References: <20030623221541.GA8096@alf.amelek.gda.pl> <20030623222311.GD25982@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623222311.GD25982@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 11:23:11PM +0100, Matthew Wilcox wrote:
> Have you patched 2.4.21 with the latest ACPI patch, or is this vanilla
> 2.4.21?

Vanilla 2.4.21 - tried 2.4.21-ac1 once, but it said Oops at boot time
(something about the VIA686A sound driver - not related to ACPI).

Marek

