Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSEVNcR>; Wed, 22 May 2002 09:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSEVNcQ>; Wed, 22 May 2002 09:32:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313419AbSEVNcP>; Wed, 22 May 2002 09:32:15 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: padraig@antefacto.com (Padraig Brady)
Date: Wed, 22 May 2002 14:52:19 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3CEB9A1B.9040905@antefacto.com> from "Padraig Brady" at May 22, 2002 02:16:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AWXL-0001md-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /sbin/kbdrate: util-linux

I'd hope kbrate is using the ioctls nowdays, otherwise it will break on USB
