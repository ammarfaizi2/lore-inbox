Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277216AbRJDUgk>; Thu, 4 Oct 2001 16:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277212AbRJDUgc>; Thu, 4 Oct 2001 16:36:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29455 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277216AbRJDUgQ>; Thu, 4 Oct 2001 16:36:16 -0400
Subject: Re: PATCH - gameport_{,un}register_port must be static when inline
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 4 Oct 2001 21:41:08 +0100 (BST)
Cc: neilb@cse.unsw.edu.au (Neil Brown),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <11147.1002169889@kao2.melbourne.sgi.com> from "Keith Owens" at Oct 04, 2001 02:31:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pFIq-00042P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please don't.  This was fixed in the -ac trees several weeks ago, the
> correct fix is to move the input rewrite from -ac to Linus's tree.
> That is up to the maintainer, Vojtech Pavlik.

The core stuff has been done and I've sent Linus the remaining pieces
now.
