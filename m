Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278724AbRJVL07>; Mon, 22 Oct 2001 07:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278725AbRJVL0o>; Mon, 22 Oct 2001 07:26:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12809 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278724AbRJVL0Z>; Mon, 22 Oct 2001 07:26:25 -0400
Subject: Re: 2.4.12-ac5: i810_audio does not work#
To: pavenis@latnet.lv (Andris Pavenis)
Date: Mon, 22 Oct 2001 12:32:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200110221115.f9MBFGG03559@hal.astr.lu.lv> from "Andris Pavenis" at Oct 22, 2001 02:15:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vdKC-0001eY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> reverted one of the patches between 2.4.6-ac1 and 2.4.6-ac2) which mostly 
> works for KDE with fragment size up to 512 bytes. 2.4.7 worked with any fragment 
> size set in kcontrol.

Thanks

> I haven't tested much under GNOME, as I'm starting it very seldom

Gnome esd is very simple in how it drives the hardware - it works in many 
cases where drivers are buggy and arts shows up problems

