Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBNTw3>; Wed, 14 Feb 2001 14:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129227AbRBNTwT>; Wed, 14 Feb 2001 14:52:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31505 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129107AbRBNTwH>; Wed, 14 Feb 2001 14:52:07 -0500
Subject: Re: Linux 2.2.19pre12
To: jgarzik@mandrakesoft.mandrakesoft.com (Jeff Garzik)
Date: Wed, 14 Feb 2001 19:52:38 +0000 (GMT)
Cc: akorud@polynet.lviv.ua (Andriy Korud), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010214131123.6565N-100000@mandrakesoft.mandrakesoft.com> from "Jeff Garzik" at Feb 14, 2001 01:12:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T7yi-0005ph-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > hosts.c:500: `AIC7XXX' undeclared here (not in a function)
> > hosts.c:500: initializer element for `builtin_scsi_hosts[0]' is not constant
> 
> I'm sure Alan will notice and pick up the proper fix.  For a workaround
> to get you going, you can change hosts.c to include aic7xxx/aic7xxx.h...

It already does, and builds.
