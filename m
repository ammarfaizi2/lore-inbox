Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVAYU3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVAYU3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVAYU3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:29:51 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:64699 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262114AbVAYU3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:29:36 -0500
Message-ID: <41F6AC38.2060307@comcast.net>
Date: Tue, 25 Jan 2005 15:29:44 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <d120d50005012510571d77338d@mail.gmail.com> <41F6A45D.1000804@comcast.net> <20050125202501.GA21764@fieldses.org>
In-Reply-To: <20050125202501.GA21764@fieldses.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



J. Bruce Fields wrote:
> On Tue, Jan 25, 2005 at 02:56:13PM -0500, John Richard Moser wrote:
> 
>>In this context, it doesn't make sense to deploy a protection A or B
>>without the companion protection, which is what I meant.
> 
> 
> But breaking up the introduction of new code into logical steps is still
> helpful for people trying to understand the new code.
> 
> Even if it's true that it's no use locking any door until they are all
> locked, there's still some value to allowing people to watch you lock
> each door individually.  It's easier for them to understand what you're
> doing that way.
> 

I guess so.

This still doesn't give me any way to take a big patch and make little
patches without hours of work and (N+2) kernel trees for N patches
> --Bruce Fields
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9qw3hDd4aOud5P8RAq+AAJ4ynZrASPcnh87ziZ1ZWrmzF9V44gCdHQXh
yZQ7Z9J7gJ4GWr3zaXM6Qx8=
=/4Ze
-----END PGP SIGNATURE-----
