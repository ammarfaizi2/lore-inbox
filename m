Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbREOI6B>; Tue, 15 May 2001 04:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbREOI5v>; Tue, 15 May 2001 04:57:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24590 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262687AbREOI5n>; Tue, 15 May 2001 04:57:43 -0400
Subject: Re: 2.4 To Pending Device Number Registrants
To: ahu@ds9a.nl (bert hubert)
Date: Tue, 15 May 2001 09:54:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.org
In-Reply-To: <20010515094835.A13650@home.ds9a.nl> from "bert hubert" at May 15, 2001 09:48:36 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zabB-0002DM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I would think that this block of new major number allocations holds for
> 2.5 and not 2.4. Also, if I'm correct, 2.4 won't be needing a lot of new
> major numbers anyhow.

I wouldnt bet on that. Going to a 32bit dev_t internally without user space
noticing would keep it seems to be quite doable if we have to. Right now doesnt
worry me, in 2 years time when 2.6 is approaching release the picture might
have changed a fair bit

