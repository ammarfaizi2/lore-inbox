Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSK0ImK>; Wed, 27 Nov 2002 03:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSK0ImK>; Wed, 27 Nov 2002 03:42:10 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:42981 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261689AbSK0ImJ> convert rfc822-to-8bit; Wed, 27 Nov 2002 03:42:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PROPOSAL] Network Load Balance
Date: Wed, 27 Nov 2002 09:48:38 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: "Joao Alberto M. dos Reis (Listas de discucao)" <lista@vudu.ath.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211270948.38546.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joao,

> I know that in windows you need a capable ethernet adapter (Intel with
> adaptive load balance feature) and the intel's load balance driver. Do I
> have to have special hardware or driver to make the linux kernel's bonding?
This can be done with every NIC. Just read:
<file: Documentation/networking/bonding.txt>

and set it up.

ciao, Marc




