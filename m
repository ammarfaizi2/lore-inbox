Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBCH6f>; Sat, 3 Feb 2001 02:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129035AbRBCH6Z>; Sat, 3 Feb 2001 02:58:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36362 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129033AbRBCH6Q>; Sat, 3 Feb 2001 02:58:16 -0500
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: paul@clubi.ie (Paul Jakma)
Date: Sat, 3 Feb 2001 07:58:42 +0000 (GMT)
Cc: jakub@redhat.com (Jakub Jelinek), jamagallon@able.es (J . A . Magallon),
        reiser@namesys.com (Hans Reiser), alan@redhat.com (Alan Cox),
        mason@suse.com (Chris Mason), kas@informatics.muni.cz (Jan Kasprzak),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu . Rupasov)
In-Reply-To: <Pine.LNX.4.31.0102030420031.20193-100000@fogarty.jakma.org> from "Paul Jakma" at Feb 03, 2001 04:25:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Oxam-0007zT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > compiler (e.g. on sparc64). This test will barf on gcc-2.96 up to -67 and
> > 	Jakub
> 
> ehhmm..
> 
> didn't barf here with 2.96-70.

Which is correct

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
