Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132004AbRBEMDW>; Mon, 5 Feb 2001 07:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132018AbRBEMDM>; Mon, 5 Feb 2001 07:03:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48658 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132004AbRBEMCw>; Mon, 5 Feb 2001 07:02:52 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
To: greg@linuxpower.cx (Gregory Maxwell)
Date: Mon, 5 Feb 2001 12:02:48 +0000 (GMT)
Cc: ahzz@terrabox.com (Brian Wolfe), reiser@namesys.com (Hans Reiser),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
In-Reply-To: <20010205002119.A31043@xi.linuxpower.cx> from "Gregory Maxwell" at Feb 05, 2001 12:21:19 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PkM7-0003CA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No. There are *many* other compilers out there which are much *more* broken
> then anything RedHat has recently shipped. Unfortunatly, there is no easy
> way to accuratly test for such bugs (because once they can be boiled down to
> a simple test they are very rapidly fixed, what's left is voodoo).

The problem isn't so much that compilers get bugs and they get fixed as
soon as a good test case pops up, its that end users don't habitually check
for a compiler update. Being able to say 'look go get a new compiler' is
productive. Especially as the kernel can panic with a URL ;)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
