Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279790AbRKRO6O>; Sun, 18 Nov 2001 09:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279783AbRKRO6E>; Sun, 18 Nov 2001 09:58:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4613 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279778AbRKRO56>; Sun, 18 Nov 2001 09:57:58 -0500
Subject: Re: New ac patch???
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Sun, 18 Nov 2001 15:05:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111181543130.23449-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Nov 18, 2001 03:43:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165TW2-0003UJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When will the AC patches follow the linus tree?

Right now I've fed all the stuff I feel makes sense to Linus for 2.4.15.
Once 2.4.15 is out I'll send some more bits to Marcelo, and also some bits
to Linus that are 2.5 material (eg PnPBIOS). The only "-ac" patch as such
would be for 32bit quota and other oddments so I don't think its worth the
effort.

Alan
