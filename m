Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315559AbSEVOro>; Wed, 22 May 2002 10:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315553AbSEVOqC>; Wed, 22 May 2002 10:46:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57105 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315539AbSEVOpS>; Wed, 22 May 2002 10:45:18 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 22 May 2002 16:04:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <3CEB9157.2080308@evision-ventures.com> from "Martin Dalecki" at May 22, 2002 02:38:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AXfM-0001xc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Xfree86 people are actually sane and hold up the BSD tradition.
> They don't even use /proc/bus and killed early /proc/agpgart usage!
> Quite the reverse is true.

XFree86 uses /proc/cpuinfo, /proc/bus/pci, /proc/mtrr, /proc/fb, /proc/dri
and even such goodies as /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes

Alan

