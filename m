Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSHOHpv>; Thu, 15 Aug 2002 03:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSHOHpv>; Thu, 15 Aug 2002 03:45:51 -0400
Received: from jabberwock.ucw.cz ([212.71.128.53]:56326 "HELO
	jabberwock.ucw.cz") by vger.kernel.org with SMTP id <S315919AbSHOHpu>;
	Thu, 15 Aug 2002 03:45:50 -0400
Date: Thu, 15 Aug 2002 09:49:44 +0200
From: Martin Mares <mj@ucw.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'colpatch@us.ibm.com'" <colpatch@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>, jgarzik@mandrakesoft.com,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>
Subject: Re: [patch] PCI Cleanup
Message-ID: <20020815094943.A880@ucw.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD92@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DD92@orsmsx119.jf.intel.com>; from andrew.grover@intel.com on Wed, Aug 14, 2002 at 07:24:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> ACPI needs access to PCI config space, and it doesn't have a struct pci_dev
> to pass to access functions. It doesn't look like your patch exposes an
> interface that 1) doesn't require a pci_dev and 2) abstracts the PCI config
> access method, does it?

What interface would you like to see?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
No fortune, no luck, no sig!
