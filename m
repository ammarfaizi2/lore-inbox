Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBEMMD>; Mon, 5 Feb 2001 07:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRBEMLy>; Mon, 5 Feb 2001 07:11:54 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:5900 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129031AbRBEMLn>; Mon, 5 Feb 2001 07:11:43 -0500
Message-ID: <3A7E90B0.86ED1167@namesys.com>
Date: Mon, 05 Feb 2001 14:38:24 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Gregory Maxwell <greg@linuxpower.cx>, Brian Wolfe <ahzz@terrabox.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink 
 related)
In-Reply-To: <E14PkM7-0003CA-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > No. There are *many* other compilers out there which are much *more* broken
> > then anything RedHat has recently shipped. Unfortunatly, there is no easy
> > way to accuratly test for such bugs (because once they can be boiled down to
> > a simple test they are very rapidly fixed, what's left is voodoo).
> 
> The problem isn't so much that compilers get bugs and they get fixed as
> soon as a good test case pops up, its that end users don't habitually check
> for a compiler update. Being able to say 'look go get a new compiler' is
> productive. Especially as the kernel can panic with a URL ;)
> 
> Alan

Here we agree.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
