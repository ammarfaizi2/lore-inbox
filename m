Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbRESSCI>; Sat, 19 May 2001 14:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261940AbRESSB6>; Sat, 19 May 2001 14:01:58 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:28154
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S261930AbRESSBn>; Sat, 19 May 2001 14:01:43 -0400
Date: Sat, 19 May 2001 14:01:20 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ben LaHaise <bcrl@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Andrew Morton <andrewm@uow.edu.au>, <Andries.Brouwer@cwi.nl>,
        <torvalds@transmeta.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <E1519Xe-00005c-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105191352340.7806-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Alan Cox wrote:

> > Now that I'm awake and refreshed, yeah, that's awful.  But
> > echo "hot-add,slot=5,device=/dev/sda" >/dev/md0/control *is* sane.  Heck,
> > the system can even send back result codes that way.
>
> Only to an English speaker. I suspect Quebec City canadians would prefer a
> different command set.

Well...  Around here we've been used to Microsoft translations like:

ETES-VOUS CERTAIN [O/N] ?

... and of course pressing 'o' doesn't work while 'y' does.  :-)

Wanting to localize such low-level keywords is utopia.  Otherwise you'll
want to translate command names like free, rm, mv, etc. and yet programming
languages as well like C keywords.  And then you come to a point where
nothing could be interoperable any more.


Nicolas

