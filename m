Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262822AbRFCHui>; Sun, 3 Jun 2001 03:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbRFCHu2>; Sun, 3 Jun 2001 03:50:28 -0400
Received: from [213.128.193.148] ([213.128.193.148]:47888 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262822AbRFCHuQ>;
	Sun, 3 Jun 2001 03:50:16 -0400
Date: Sun, 3 Jun 2001 11:46:28 +0400
Message-Id: <200106030746.f537kSZ12820@linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
To: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
In-Reply-To: <20010603002310.A8817@lightning.swansea.linux.org.uk>
X-Newsgroups: linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.5-ac6 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

In article <20010603002310.A8817@lightning.swansea.linux.org.uk> you wrote:

AC> 2.4.5-ac7
AC> o       Make USB require PCI                            (me)
Huh?!
How about people from StrongArm sa11x0 port, who have USB host controller (in
sa1111 companion chip) but do not have PCI?
Probably there are more such embedded architectures with USB controllers,
but not PCI bus.
How about ISA USB host controllers?

Bye,
    Oleg
