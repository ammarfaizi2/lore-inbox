Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272118AbRINQ6G>; Fri, 14 Sep 2001 12:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272580AbRINQ55>; Fri, 14 Sep 2001 12:57:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65291 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272118AbRINQ5k>; Fri, 14 Sep 2001 12:57:40 -0400
Subject: Re: 2.4, 2.4-ac and quotas
To: matt@theBachChoir.org.uk (Matt Bernstein)
Date: Fri, 14 Sep 2001 18:02:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109141730410.30680-100000@nick.dcs.qmul.ac.uk> from "Matt Bernstein" at Sep 14, 2001 05:45:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15hwLr-0000Zl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We've recently upgraded our two Debian potato fileservers to 2.4 and
> 2.4-ac (currently they're both running 2.4-ac so I can't check 2.4 atm)
> and quotas have stopped working.

The -ac kernels use the updated quota tools - they are needed to support
32bit uid quota
