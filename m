Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262504AbRENV2c>; Mon, 14 May 2001 17:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262505AbRENV2W>; Mon, 14 May 2001 17:28:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4362 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262504AbRENV2E>; Mon, 14 May 2001 17:28:04 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: riel@conectiva.com.br (Rik van Riel)
Date: Mon, 14 May 2001 22:23:59 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.33.0105141802070.18102-100000@duckman.distro.conectiva> from "Rik van Riel" at May 14, 2001 06:11:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zPot-0001Sa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been doubting whether to work on both the -ac kernels
> and the -linus tree, but this is a pretty good argument for
> sticking with -ac and just ignoring the -linus tree...

Time will make that decision. Linus kindly gave us all the power to vote with
our feet. One thing I absolutely refuse to do is to let a disagreemnt over
some specific device implementation turn into an excuse for a wider difference
in the trees.

So yes -ac might have static majors but the rest of it I intend to keep merging
with Linus and tracking closely to his tree. Certainly not ignoring the -linus
tree. 

Alan

