Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTKBDQr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 22:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTKBDQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 22:16:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15297 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261311AbTKBDQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 22:16:46 -0500
Date: Sun, 2 Nov 2003 03:16:44 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Noah J. Misch" <noah@caltech.edu>
Cc: linux-ia64@linuxia64.org, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
Message-ID: <20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.58.0310251706470.15711@inky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0310251706470.15711@inky>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 04:35:11PM -0800, Noah J. Misch wrote:
> Greetings,
> 
> I found the Kconfig logic for ACPI and IA64, as defined in arch/ia64/Kconfig and
> drivers/acpi/Kconfig to be a bit redundant and hard to follow.  It appears to do
> the following:

I posted a similar patch here:

http://marc.theaimsgroup.com/?l=linux-ia64&m=106555019402117&w=2

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
