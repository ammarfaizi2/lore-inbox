Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278091AbRJVIJq>; Mon, 22 Oct 2001 04:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278313AbRJVIIq>; Mon, 22 Oct 2001 04:08:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54791 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278275AbRJVIIR>; Mon, 22 Oct 2001 04:08:17 -0400
Subject: Re: Linux 2.4.12-ac5
To: rml@tech9.net (Robert Love)
Date: Mon, 22 Oct 2001 09:15:13 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        reality@delusion.de (Udo A. Steinberg), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel),
        laughing@shared-source.org
In-Reply-To: <1003737827.1712.39.camel@phantasy> from "Robert Love" at Oct 22, 2001 04:03:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vaEr-00019X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can it be made a config setting? "Use ACPI to determine irq routing or
> whatever" ... it can even default to on.  One good thing to note is that
> it is all init/initdata, but its still a bloat of the kernel image.

In time probably - for now it is best set up with an option.
