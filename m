Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280728AbRKBQp1>; Fri, 2 Nov 2001 11:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280729AbRKBQpR>; Fri, 2 Nov 2001 11:45:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59142 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280728AbRKBQpH>; Fri, 2 Nov 2001 11:45:07 -0500
Subject: Re: Linux 2.4.13-ac6
To: whitney@math.berkeley.edu
Date: Fri, 2 Nov 2001 16:51:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LKML), laughing@shared-source.org (Alan Cox)
In-Reply-To: <200111021638.fA2GcLs03275@adsl-209-76-109-63.dsl.snfc21.pacbell.net> from "Wayne Whitney" at Nov 02, 2001 08:38:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zhXY-0002sv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_IDE_TASK_IOCTL

Adds extra ioctls for doing specific tasks within the ide layer - think of
taskfile as an ide scheduler

> CONFIG_IDEDMA_ONLYDISK

Do windowslike UDMA on disks PIO on cdrom


The other two Andre had best explain

