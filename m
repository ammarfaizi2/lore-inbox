Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129738AbRBEMxU>; Mon, 5 Feb 2001 07:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129888AbRBEMxM>; Mon, 5 Feb 2001 07:53:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:531 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129738AbRBEMw7>; Mon, 5 Feb 2001 07:52:59 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
To: reiser@namesys.com (Hans Reiser)
Date: Mon, 5 Feb 2001 12:52:52 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        ahzz@terrabox.com (Brian Wolfe),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
In-Reply-To: <3A7E998A.9CB7A4B3@namesys.com> from "Hans Reiser" at Feb 05, 2001 03:16:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Pl8Z-0003Hj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I was thinking boot time.
> and if reiserfs is the root partition?  You really want to make them reboot to
> the old kernel and recompile rather than making them just recompile?

I want to make sure they get a sane clear message telling them where to
find the correct compiler and that they didnt read the docs

> Stop trying to blame something other than the compiler, it is ridiculous.

WTF does it have to dow with blaming something other than the compiler ?

Its going to print something like

Linux 2.4.2-ac3 blah blah
Error: This kernel was built with a buggy gcc. Please go to 
	http://.... and upgrade


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
