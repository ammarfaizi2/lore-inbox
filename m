Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280134AbRKIVXP>; Fri, 9 Nov 2001 16:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280161AbRKIVXL>; Fri, 9 Nov 2001 16:23:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13580 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280134AbRKIVWA>; Fri, 9 Nov 2001 16:22:00 -0500
Subject: Re: X-Windows locks up under concurrent OpenGL (Mesa) and I/O on Athlon
To: Richard.Gaudette@Colorado.EDU (Rick Gaudette)
Date: Fri, 9 Nov 2001 21:29:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1005340278.6168.21.camel@wanderer> from "Rick Gaudette" at Nov 09, 2001 02:11:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E162JDA-0004Jg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am submitting this to the kernel mailing list on the hunch that
> intense system usage appears to be causing a deadlock that goes away
> when AGP usage is disabled.

Can you also submit it to
	https://bugzilla.redhat.com/bugzilla

> X-Windows locks up under concurrent OpenGL (Mesa) and I/O on Athlon
> based motherboards with VIA and AMD chipsets and AGP enabled.  This
> problem does NOT occur on Pentium III and Pentium IV based systems with
> Intel chipsets.  Nor, if AGP is disabled.

The AMD chipset ones sound familiar (see the AMD errata stuff) the VIA ones
suprise me.

Alan
