Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277235AbRJIOM0>; Tue, 9 Oct 2001 10:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277238AbRJIOMQ>; Tue, 9 Oct 2001 10:12:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5385 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277235AbRJIOME>; Tue, 9 Oct 2001 10:12:04 -0400
Subject: Re: sysctl interface to bootflags?
To: jdthood@mail.com (Thomas Hood)
Date: Tue, 9 Oct 2001 15:18:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1002636089.953.115.camel@thanatos> from "Thomas Hood" at Oct 09, 2001 10:01:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qxhu-0004Js-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it be a good idea to do this using the sysctl infrastructure?
> If so, can someone please suggest an appropriate pathname for
> the flag files?  How about "/proc/sys/BIOS/bootflags/diagnostics"
> and "/proc/sys/BIOS/bootflags/PnP-OS" ?

Userspace can already do it via /dev/nvram
