Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131394AbRBELzd>; Mon, 5 Feb 2001 06:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131690AbRBELzW>; Mon, 5 Feb 2001 06:55:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42770 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131394AbRBELzS>; Mon, 5 Feb 2001 06:55:18 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
To: ahzz@terrabox.com (Brian Wolfe)
Date: Mon, 5 Feb 2001 11:55:16 +0000 (GMT)
Cc: reiser@namesys.com (Hans Reiser), alan@lxorguk.ukuu.org.uk (Alan Cox),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
In-Reply-To: <20010204205013.D23921@ironsides.terrabox.com> from "Brian Wolfe" at Feb 04, 2001 08:50:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PkEo-0003B2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> administrator that has worked in large multi hundred million dollar compani=
> es where 1 hour of downtime =3D=3D $75,000 in lost income proactive prevent=
> ion IS the right answer. If the gcc people need to compile with the .96 rh =
> version then they can apply a removal patch hans provides in the crash mess=
> age. This makes it easy to remove the safeguard and blow yourself up at wil=
> l after being suitibly called a dumbass.

With all due respect, if you are running $75,000/hr of lost income (which btw
is small fry to a lot of folks) shouldn't you have an engineering team who
a) read the documentation. 
b) run tests before rolling out software

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
