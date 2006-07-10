Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWGJFcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWGJFcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 01:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWGJFcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 01:32:31 -0400
Received: from xenotime.net ([66.160.160.81]:11942 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751340AbWGJFca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 01:32:30 -0400
Date: Sun, 9 Jul 2006 22:35:16 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-acpi@vger.kernel.org, greg@kroah.com
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060709223516.f70827e1.rdunlap@xenotime.net>
In-Reply-To: <44B0E6E6.6070904@reub.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<44B0E6E6.6070904@reub.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jul 2006 23:22:14 +1200 Reuben Farrelly wrote:

> 2. Onto some more minor warnings:
> 
> ACPI: bus type pci registered
> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> PCI: Not using MMCONFIG.
> PCI: Using configuration type 1

Yes, I have all of those.

> ACPI: Interpreter enabled
> 
> Is there any way to verify that there really is a BIOS bug there?  If it is, is 
> there anyone within Intel or are there any known contacts who can push and poke 
> to get this looked at/fixed?  (It's a new Intel board, I'd hope they could get 
> it right..).
> 
> Plus we're not using MMCONFIG - even though I have it enabled.
> 
> Based on previous postings to lkml, I believe Randy Dunlap may have one of these 
> boards too - Randy are you seeing this and the next bunch of warnings I am seeing?

Yes, but Len says that they (*/namespace/*) will be going away.

---
~Randy
