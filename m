Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313582AbSDHIEx>; Mon, 8 Apr 2002 04:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313583AbSDHIEw>; Mon, 8 Apr 2002 04:04:52 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16905 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313582AbSDHIEv>; Mon, 8 Apr 2002 04:04:51 -0400
Message-ID: <3CB14ECD.43E97BD8@aitel.hist.no>
Date: Mon, 08 Apr 2002 10:03:25 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: nahshon@actcom.co.il, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu> <200204060007.g3607I525699@lmail.actcom.co.il> <20020407144246.C46@toy.ucw.cz> <200204080048.g380mt514749@lmail.actcom.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itai Nahshon wrote:
> 
> On Sunday 07 April 2002 17:42 pm, Pavel Machek wrote:
> > Hi!
> >
> > > I'm curios, how much work can you accomplish on your laptop
> > > without any disk access (but you still need to save files - keeping
> > > them in buffers until it's time to actually write them).
> >
> > Debugging session (emacs/gcc/gdb) for half an hour with disks stopped is
> > easy to accomplish.
> >                                                               Pavel
> 
> My suggestion was: there should _never_ be dirty blocks for disks that
> are not spinning. 

Why not?  Are you afraid that the spun-down disk won't
start the next time it is needed?

Helge Hafting
