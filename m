Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRGZWTi>; Thu, 26 Jul 2001 18:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268713AbRGZWT2>; Thu, 26 Jul 2001 18:19:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268714AbRGZWTO>; Thu, 26 Jul 2001 18:19:14 -0400
Subject: Re: Support for serial console on legacy free machines
To: khalid@fc.hp.com (Khalid Aziz)
Date: Thu, 26 Jul 2001 23:20:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <no.id> from "Khalid Aziz" at Jul 26, 2001 03:13:50 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PtU8-0004cZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> console is "Serial Port Console Redirection" (SPCR) table. This table
> gives me almost all the information I need to initialize and use a
> serial console. The bummer is this table was designed by Microsoft and
> Microsoft owns the copyright on it. Microsoft primarily designed this
> table for use by Whistler. Their copyright may cause potential problems
> with using it in Linux. This makes me reluctant to use this table. I

Such as ?

If its a table that microsoft added to ACPI and its well thought out I don't
see a big problem technically. There are a collection of BIOS services we
use that were microsoft originated
