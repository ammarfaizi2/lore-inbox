Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbRFGRyu>; Thu, 7 Jun 2001 13:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262686AbRFGRyl>; Thu, 7 Jun 2001 13:54:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51976 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262684AbRFGRy1>; Thu, 7 Jun 2001 13:54:27 -0400
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
To: hps@intermeta.de
Date: Thu, 7 Jun 2001 18:52:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9fnjh0$d1c$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at Jun 07, 2001 10:03:12 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1583xV-0001f3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And this is legal according to the "Kernel GPL, Linus Torvalds edition
> (TM)" which says "any loadable module can be binary only". Not "only
> loadable modules which are drivers". It may not be the intention but
> it is the fact.

Linus opinion on this is irrelevant. Neither I nor the FSF nor many others
have released code under anything but the vanilla GPL. By merging such code
Linus lost his ability to vary the license.

So it comes down to the question of whether the module is linking (which is
about dependancies and requirements) and what the legal scope is. Which
is a matter for lawyers.

Anyone releasing binary only modules does so having made their own appropriate
risk assessment and having talked (I hope) to their insurers

