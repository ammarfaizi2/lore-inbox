Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRBEMpU>; Mon, 5 Feb 2001 07:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132379AbRBEMpK>; Mon, 5 Feb 2001 07:45:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60946 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129694AbRBEMov>; Mon, 5 Feb 2001 07:44:51 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
To: reiser@namesys.com (Hans Reiser)
Date: Mon, 5 Feb 2001 12:44:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        ahzz@terrabox.com (Brian Wolfe),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
In-Reply-To: <3A7E904F.797AF09B@namesys.com> from "Hans Reiser" at Feb 05, 2001 02:36:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Pl0J-0003G8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thats actually quite doable. I'll see about dropping the test into -ac that
> > way.
> NOOOOO!!!!!! It should NOT fail at mount time, it should fail at compile time.

I was thinking boot time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
