Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132055AbRBKJXl>; Sun, 11 Feb 2001 04:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132094AbRBKJXb>; Sun, 11 Feb 2001 04:23:31 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:43529 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S132055AbRBKJXW>; Sun, 11 Feb 2001 04:23:22 -0500
Message-ID: <3A865260.2FB37723@namesys.com>
Date: Sun, 11 Feb 2001 11:50:40 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Daniel Stone <daniel@kabuki.eyep.net>, Chris Mason <mason@suse.com>,
        David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <E14RbJG-0001ds-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Before you put that down to reiserfs can you chek 2.4.2-pre2. It may be
> problems below the reiserfs layer

I forgot, this bug exists on reiserfs for Linux 2.2.*, so it isn't going to be
fixed by 2.4.2 (assuming that the bug is not in 2.2.*).

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
