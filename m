Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbRBBWkV>; Fri, 2 Feb 2001 17:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbRBBWkL>; Fri, 2 Feb 2001 17:40:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1801 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130378AbRBBWj5>; Fri, 2 Feb 2001 17:39:57 -0500
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 2 Feb 2001 22:40:19 +0000 (GMT)
Cc: alan@redhat.com (Alan Cox), john@vmlinux.net (John Morrison),
        mason@suse.com (Chris Mason), kas@informatics.muni.cz (Jan Kasprzak),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu. Rupasov)
In-Reply-To: <3A7B2E94.F52C4342@namesys.com> from "Hans Reiser" at Feb 03, 2001 01:03:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OosP-0007KT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > their kernel, something putting #ifdefs all over it will mean they have to
> > mess around to fix too.
> > 
> A moment of precision here.  We won't test to see if the right compiler is used,
> we will just test for the wrong one. 

Ok that makes a lot more sense
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
