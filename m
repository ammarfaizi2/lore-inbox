Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbREPUjL>; Wed, 16 May 2001 16:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbREPUjB>; Wed, 16 May 2001 16:39:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21513 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262081AbREPUi4>; Wed, 16 May 2001 16:38:56 -0400
Subject: Re: FW: I think I've found a serious bug in AMD Athlon page_alloc.c routines, where do I mail the developer(s) ?
To: davew@sai.co.za (David Wilson)
Date: Wed, 16 May 2001 21:35:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <NEBBJFIIGKGLPEBIJACLAEHEDMAA.davew@sai.co.za> from "David Wilson" at May 16, 2001 01:12:15 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15080y-0004AI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if DFI has a bios or chipset patch available and whether that would
> help ?
> Maybe disabling the VIA chipset support in the kernel and running generic
> drivers would help ?

Play with ideas see what you find out. You might strike lucky. So far nobody
else has
