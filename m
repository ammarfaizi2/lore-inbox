Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136016AbREBX6n>; Wed, 2 May 2001 19:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136092AbREBX6X>; Wed, 2 May 2001 19:58:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34323 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136016AbREBX6P>; Wed, 2 May 2001 19:58:15 -0400
Subject: Re: [OT] Interrupting select.
To: ptb@it.uc3m.es
Date: Thu, 3 May 2001 01:01:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lar@cs.york.ac.uk,
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <200105022303.f42N36825429@oboe.it.uc3m.es> from "Peter T. Breuer" at May 03, 2001 01:03:06 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14v6YM-0004bN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [seriously man sigaction]
> Equally seriously .. all signals are unblocked in my code and always
[see man signaction]

>              struct sigaction sa =3D { {sighandler}, {{0}}, SA_RESTART, N=
                                        subtle hint---->      ^^^^^^^^^^
> 

