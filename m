Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263102AbRE1RIY>; Mon, 28 May 2001 13:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbRE1RIO>; Mon, 28 May 2001 13:08:14 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:34542 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S263102AbRE1RIF>;
	Mon, 28 May 2001 13:08:05 -0400
Message-ID: <3B1285CC.EB151D8A@pcsystems.de>
Date: Mon, 28 May 2001 19:07:24 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fischer@norbit.de
Subject: aha152x problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I tried to load thie aha152x modules:

modprobe aha152x io=0x140 irq=9 (which is correct)
entries in /proc/scsi are generated,
but the modprobe hangs and is unkillable.
aha152x reports scsi discs to the kernel messages,
although there are none connected to it.

I tried to use a scanner, but it it impossible
to work with the controller.

Did I miss any patches/ fixes ?


Nico

using 2.4.4

