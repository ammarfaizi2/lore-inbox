Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRBBWvL>; Fri, 2 Feb 2001 17:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbRBBWvB>; Fri, 2 Feb 2001 17:51:01 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:2569 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S130073AbRBBWuv>; Fri, 2 Feb 2001 17:50:51 -0500
Message-ID: <3A7B31B9.CBD13EEA@namesys.com>
Date: Sat, 03 Feb 2001 01:16:25 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alan Cox <alan@redhat.com>, John Morrison <john@vmlinux.net>,
        Chris Mason <mason@suse.com>, Jan Kasprzak <kas@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <E14OosP-0007KT-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > their kernel, something putting #ifdefs all over it will mean they have to
> > > mess around to fix too.
> > >
> > A moment of precision here.  We won't test to see if the right compiler is used,
> > we will just test for the wrong one.
> 
> Ok that makes a lot more sense

Ok, so with that last clarification, we are all in agreement I think.

Thanks for the code frag Alan,

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
