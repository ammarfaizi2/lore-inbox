Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280768AbRKBS1g>; Fri, 2 Nov 2001 13:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280769AbRKBS10>; Fri, 2 Nov 2001 13:27:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63495 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280768AbRKBS1L>; Fri, 2 Nov 2001 13:27:11 -0500
Subject: Re: APM/ACPI
To: smiddle@twp.ypsilanti.mi.us (Sean Middleditch)
Date: Fri, 2 Nov 2001 18:34:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1004725424.4883.33.camel@smiddle> from "Sean Middleditch" at Nov 02, 2001 01:23:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zj8q-0003CI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see anything regarding ACPI.  I also read that ACPI should
> automatically take over APM if support is available.  How can I tell if
> I'm not using ACPI because it's not supported, or because it's not
> compiled in?

Red Hat shipped kernels dont include acpi. The -1% for the battery
percentage does look like the laptop may not support much APM if any
