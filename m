Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285590AbRL1BE7>; Thu, 27 Dec 2001 20:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284017AbRL1BEt>; Thu, 27 Dec 2001 20:04:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11271 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283938AbRL1BEp>; Thu, 27 Dec 2001 20:04:45 -0500
Subject: Re: ISA core vs. ISA card support
To: esr@thyrsus.com
Date: Fri, 28 Dec 2001 01:15:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20011227194444.A26341@thyrsus.com> from "Eric S. Raymond" at Dec 27, 2001 07:44:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Jlc8-0007ZK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # There are PCI-only machines out there, but as of 2.4.0-test1 I'm told
> # nobody has tested the kernel with an x86 lacking ISA.  Giacomo Catenazzi

I have tested on a couple of legacy free boxes. However they still have
what were once ISA devices lurking (IDE initial setup etc). Many PCI only
boxes have serial ports, parallel, floppy, even ISA style audio devices
on the mainboard internal busses

ISA slots I agree is a useful distinction however
