Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280778AbRKBSog>; Fri, 2 Nov 2001 13:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280785AbRKBSoa>; Fri, 2 Nov 2001 13:44:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9224 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280781AbRKBSnp>; Fri, 2 Nov 2001 13:43:45 -0500
Subject: Re: APM/ACPI
To: smiddle@twp.ypsilanti.mi.us (Sean Middleditch)
Date: Fri, 2 Nov 2001 18:50:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1004726512.4921.41.camel@smiddle> from "Sean Middleditch" at Nov 02, 2001 01:41:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zjOs-0003FH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, so there's a good chance then that if I compile in ACPI I can have
> things work OK.  Do I need something besides apmd to handle all that? 
> Will stuff like the GNOME battery applet still work?

If you compile in ACPI your box might work. You will need different 
(development) tools and suspend wont work yet. ACPI is getting to the 
useful point but not quite there - expect an adventure
