Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154342-662>; Fri, 9 Oct 1998 01:08:37 -0400
Received: from hp735.cvut.cz ([147.32.238.2]:3454 "HELO hp735.cvut.cz" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <156146-662>; Fri, 9 Oct 1998 00:37:46 -0400
Date: Fri, 9 Oct 1998 10:55:49 +0100 (MET)
From: Jan Pechanec <pechy@hp735.cvut.cz>
To: "Mike A. Harris" <mharris@ican.net>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: stackable layers in filesytem
In-Reply-To: <Pine.LNX.3.96.981008214633.923J-100000@red.prv>
Message-Id: <Pine.HPP.3.94.981009105255.26535D-100000@hp735.cvut.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 8 Oct 1998, Mike A. Harris wrote:

*>On Wed, 7 Oct 1998, Jan Pechanec wrote:
*>
*>>	please, don't you know whether the newest kernels do have
*>>"stackable layer support" for filesystem as e.g FreeBSD has?
*>
*>What exactly is stackable layer support?  Have you investigated
*>loopback filesystems?  This might be what you are looking for,
*>and has been supported in Linux for quite some time.
*>

	Generaly, see:

http://www.isi.edu/~johnh/PAPERS/Heidemann91a.html
http://www.isi.edu/~johnh/PAPERS/index.html

	in FreeBSD, see 'man mount_null'

	Loopback fs is similar to nullfs in FreeBSD, but nullfs is just an
,,application'', you can develop layer that does things like compressing,
ciphering etc.

	Jan.

*>
*>
*>
*>
*>--
*>Mike A. Harris  -  Computer Consultant  -  Linux advocate
*>
*>Linux software galore:  http://freshmeat.net
*>
*>

_________________________________________________________________________
                                                                        -
   Jan  P E C H A N E C - Computing Center, Czech Technical University  - 
                                                          ______________-
-> Zikova 4, Praha 6, 166 35, Czech Republic             /
-> http://www.civ.cvut.cz                               /
-> tel: +420 2 2435 2969  email: pechy@hp735.cvut.cz   /
-> personal www - http://akat.civ.cvut.cz/pechy       /
_____________________________________________________/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
