Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263071AbREWMeZ>; Wed, 23 May 2001 08:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263073AbREWMeQ>; Wed, 23 May 2001 08:34:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57097 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263071AbREWMeG>; Wed, 23 May 2001 08:34:06 -0400
Subject: Re: [PATCH] struct char_device
To: Andries.Brouwer@cwi.nl
Date: Wed, 23 May 2001 13:30:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        viro@math.psu.edu
In-Reply-To: <UTC200105231229.OAA19155.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at May 23, 2001 02:29:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152Xn1-0003ZF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the piggyback stuff today. This default initrd does
> the partition parsing that up to now the kernel did.
> That way nobody need to notice a difference, except for
> those who use initrd already now. They can solve their
> problems.

as a longer term path that seems reasonable. If we want large numbers of less
than guru level developers to play with 2.5 kernels for fun then its likely to
be a barrier unless its progressed stage by stage

