Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280773AbRKBSfg>; Fri, 2 Nov 2001 13:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280775AbRKBSf0>; Fri, 2 Nov 2001 13:35:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3336 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280771AbRKBSfO>; Fri, 2 Nov 2001 13:35:14 -0500
Subject: Re: APM/ACPI
To: smiddle@twp.ypsilanti.mi.us (Sean Middleditch)
Date: Fri, 2 Nov 2001 18:42:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1004725879.4921.36.camel@smiddle> from "Sean Middleditch" at Nov 02, 2001 01:31:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zjGe-0003Du-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I dunno, perhaps there is some proprietary protocol?  Is ACPI backwards
> compat with APM?  I mean, if the laptop doesn't support APM, would that
> mean it can't support ACPI?

ACPI and APM are exclusive but a BIOS can contain both. Its up to the OS
not to try and run both together.
