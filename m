Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275346AbRIZRJS>; Wed, 26 Sep 2001 13:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275344AbRIZRJI>; Wed, 26 Sep 2001 13:09:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32261 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275345AbRIZRI5>; Wed, 26 Sep 2001 13:08:57 -0400
Subject: Re: Kernel 2.4.10 - problems with X
To: wizard@eznet.net
Date: Wed, 26 Sep 2001 18:13:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BB0998C.A3E41B7A@eznet.net> from "David A. Frantz" at Sep 25, 2001 10:49:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mIFY-00015j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Obviously this has not been the case.   It would be unfortunate if I had to
> upgrade X just to get the kernel (2.4.10) to work.   Right now I'm going to
> see if I can find a set of upgrade RPMS for X.   For a RedHat 6.2 this may
> take a bit of work.

2.4.9-ac has both the old and new DRI available so you dont need to update
X11 and potentially also gtk. The dri changes should trivially transport
to the Linus tree


Alan
