Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287406AbRL3Ntn>; Sun, 30 Dec 2001 08:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287399AbRL3Ntd>; Sun, 30 Dec 2001 08:49:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287406AbRL3NtT>; Sun, 30 Dec 2001 08:49:19 -0500
Subject: Re: [kbuild-devel] Re: State of the new config & build system
To: landley@trommello.org (Rob Landley)
Date: Sun, 30 Dec 2001 13:59:28 +0000 (GMT)
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011230134125.VUHO28486.femail48.sdc1.sfba.home.com@there> from "Rob Landley" at Dec 30, 2001 12:39:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16KgUq-0001H9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Just a minor point, but what about non-PCI/ISA ide?
> > The CML1 rules seem to imply that this set is empty.
> 
> There are, apparently, paralell port IDE devices.
> 
> I've never seen one, but we've got drivers for them.  See PARIDE and 
> paride_devices.

There are IDE drives on just about every conceivable bus or interface.
	
