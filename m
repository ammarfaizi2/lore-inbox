Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317515AbSFEATj>; Tue, 4 Jun 2002 20:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317516AbSFEATi>; Tue, 4 Jun 2002 20:19:38 -0400
Received: from fmr01.intel.com ([192.55.52.18]:42456 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S317515AbSFEATh>;
	Tue, 4 Jun 2002 20:19:37 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7EDB@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Dave Jones'" <davej@suse.de>
Cc: "'Pavel Machek'" <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [patch] i386 "General Options" - begone [take 2]
Date: Tue, 4 Jun 2002 16:31:17 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@suse.de] 
>  > > Can you confirm that you're not advocating a "ACPI or Legacy" 
>  > > approach ?
>  > > I think you're aware of the dragons that lie that way, but I 
>  > > want to be sure my suspicions are unfounded.
>  > All I can say is using just *part* of ACPI will cause some machine,
>  > somewhere, to not work. I want to avoid scenarios where 
> that happens. If
>  > there are issues with that, can we discuss them asap, perhaps now?
> 
> Think vendor kernel. There we want to run on ancient pre-ACPI boxes,
> and super duper new box with borken/non-existant legacy tables.
> So just keep in mind that compiling both into the kernel is a 
> must have
> requirement.

Oh. OK. Yes. No disagreement there.

-- Andy
