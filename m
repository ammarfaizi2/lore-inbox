Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290749AbSAYRoI>; Fri, 25 Jan 2002 12:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290752AbSAYRn6>; Fri, 25 Jan 2002 12:43:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31755 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290749AbSAYRnq>; Fri, 25 Jan 2002 12:43:46 -0500
Subject: Re: ACPI mentioned on lwn.net/kernel
To: andrew.grover@intel.com (Grover, Andrew)
Date: Fri, 25 Jan 2002 17:55:22 +0000 (GMT)
Cc: lwn@lwn.net ('lwn@lwn.net'),
        acpi-devel@lists.sourceforge.net ("Acpi-linux (E-mail)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7BDF@orsmsx111.jf.intel.com> from "Grover, Andrew" at Jan 24, 2002 05:29:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UAZO-00034f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> battery status, the steps the OS must perform are defined by the BIOS.
> However, since they are performed by the OS, the OS in fact gains visibility
> into the process, and does not ever relinquish control to the BIOS.

It has task file IDE access. It is capable of being abused for that or more.
Intent doesnt come into it. Its no different to the current BIOS SMM
situation. 

Alan
