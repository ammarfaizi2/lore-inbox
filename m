Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSEVRpT>; Wed, 22 May 2002 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSEVRpS>; Wed, 22 May 2002 13:45:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13317 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316593AbSEVRpL>; Wed, 22 May 2002 13:45:11 -0400
Subject: Re: nVidia NIC/IDE/something support?
To: hjames@stevens-tech.edu (Hayden James)
Date: Wed, 22 May 2002 19:05:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.30.0205221316500.3534318-100000@attila.stevens-tech.edu> from "Hayden James" at May 22, 2002 01:20:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AaTt-0002Qp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> supported by the linux kernel.  The audio seems to be an exact clone of
> the i810 driver with just same name changes and added pci ids, you can

Already in 2.4.19pre

> get the gpl patches for it at nvidia's web site.  The rest of the

The ones behind a license that conflicts at the moment

> facilities, ide, usb etc should be supported normally by the linux kernel.

The IDE needs 2.5.x at the moment but you'll get dire PIO

> Also you will need to get the separate nVidia video driver for graphics
> support.

Better yet - help out on the utah-glx nvidia driver that way you might be
able to debug things.
