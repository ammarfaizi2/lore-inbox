Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280368AbRKEInJ>; Mon, 5 Nov 2001 03:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280372AbRKEIm7>; Mon, 5 Nov 2001 03:42:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8461 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280368AbRKEImr>; Mon, 5 Nov 2001 03:42:47 -0500
Subject: Re: APM/ACPI
To: elanthis@awesomeplay.com (Sean Middleditch)
Date: Mon, 5 Nov 2001 08:49:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        smiddle@twp.ypsilanti.mi.us (Sean Middleditch),
        linux-kernel@vger.kernel.org
In-Reply-To: <1004928598.1969.1.camel@stargrazer> from "Sean Middleditch" at Nov 04, 2001 09:49:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160fRY-0004gW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Erg, hrm.  In 2.4.13 (Debian version, Linux tree I think) I enabled
> ACPI, disabled APM.  The latop locks up when the base ACPI support is
> loaded.
> 
> How should I go about debugging this?  I want this working.

Send the apm maintainer list a report (see MAINTAINERS)
