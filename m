Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135742AbRDTHiO>; Fri, 20 Apr 2001 03:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135739AbRDTHiG>; Fri, 20 Apr 2001 03:38:06 -0400
Received: from colombina.comedia.it ([213.246.1.10]:56898 "HELO
	colombina.comedia.it") by vger.kernel.org with SMTP
	id <S135742AbRDTHhy>; Fri, 20 Apr 2001 03:37:54 -0400
Date: Fri, 20 Apr 2001 09:37:51 +0200
From: Luca Berra <bluca@comedia.it>
To: linux-lvm@sistina.com, linux-openlvm@nl.linux.org
Cc: AJ Lewis <lewis@sistina.com>, Jes Sorensen <jes@linuxcare.com>,
        linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolinux.com>,
        Arjan van de Ven <arjanv@redhat.com>, Jens Axboe <axboe@suse.de>,
        Martin Kasper Petersen <mkp@linuxcare.com>, riel@conectiva.com.br,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
Message-ID: <20010420093751.D12971@colombina.comedia.it>
Reply-To: bluca@comedia.it
Mail-Followup-To: linux-lvm@sistina.com, linux-openlvm@nl.linux.org,
	AJ Lewis <lewis@sistina.com>, Jes Sorensen <jes@linuxcare.com>,
	linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@turbolinux.com>,
	Arjan van de Ven <arjanv@redhat.com>, Jens Axboe <axboe@suse.de>,
	Martin Kasper Petersen <mkp@linuxcare.com>, riel@conectiva.com.br,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux colombina.comedia.it 2.0.36 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fuck!  I hate these things early in the morning.

what gets me extremely pissed in the whole business is that i don't
believe that splitting the mailing list is the solution to LVM problems.
Escpecially since we have a number of lusers of lwm at the time being.

I believe sistina is mostly at fault there, not for the mailing list issue
(i really don't believe people getting kicked out, while the moderation
messages are probably due to mailman braindamage)
but for political reasons (stop making it look as a sistina-only project, it pisses
everyone)

we have some serous problems here.

an lvm in the kernel which is badly broken(tm)

a better lvm (still buggy according to many kernel hackers, but better still),
which does not get into the kernel for communication reasons. (Alan can you help?
there is a lot of stuff that goes in -ac before going to mainstream)

A development model where only sistina people have access to cvs. This is bad, has the only
effect of pissing off people like Andreas which has been feeding patches and good ideas for
many months now, besides it leads to people having their own lvm tree, so everybody is
testing their development version, which has nothing to do with the version in the
goddamned kernel.

now what i propose is (some has already been said):
lets's vote for which mailing list we want to keep (and everybody accept the result)

open the goddam cvs to hackers that request access to it, you can use different branches
and do code freezes with cvs, so it won't hurt releases schedules.

try to ship the most evident bugfixes from cvs to linus, please all long-time kernel hakcers
who got involved in this help do this.

open up also the decision process (IOP 11 in beta5 and IOP 10 back in beta6
could not have happened if somebody eles knew about the IOP change.)

Regards,
L.

(Sorry for the big CC list, but i dunno who is subscribed to what anymore)



-- 
Luca Berra -- bluca@comedia.it
        Communication Media & Services S.r.l.
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \
