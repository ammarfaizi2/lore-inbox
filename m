Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263423AbREXIvx>; Thu, 24 May 2001 04:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263422AbREXIvn>; Thu, 24 May 2001 04:51:43 -0400
Received: from odin.unik.no ([193.156.96.7]:39301 "EHLO odin.unik.no")
	by vger.kernel.org with ESMTP id <S263421AbREXIvh>;
	Thu, 24 May 2001 04:51:37 -0400
Date: Thu, 24 May 2001 10:44:30 +0200 (MET DST)
From: =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@unik.no>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
cc: paalh@unik.no
Subject: sendfile
Message-ID: <Pine.GSO.4.10.10105241032120.24324-100000@kaa.unik.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm a Norwegian PhD student looking at zero-copy data paths through the OS
kernel and found sendfile to be interesting. Do this system call remove
all in-memory copy operations, i.e., sharing data buffers between file
system and com. system? (i'm sending data from disk to the network)

Is there any documentation about sendfile?

PS! I'm not a member of the mailing list so please cc the answers to my
mailing address

Thank you in advance,
-ph
---       . o  o   .  o  .  o ..  o ..  o .. o oo . o  . o o o
         _n_n_n____i_i _++++++_ _______ ________ _+++++++++++_
      *>(____________I I______I I_____I I______I I___________I
 __^__  /ooOOOO OOOOoo  oo ooo  oo   oo oo    oo ooo       ooo  __^__
( ___ )--------------------------------------------------------( ___ )
 | / | Paal Halvorsen   UniK - Center for technology at Kjeller | \ |
 | / |                                       University of Oslo | \ |
 | / | Phone: +47 64844731                               PB. 70 | \ |
 | / | Phone: +47 64844700 (switchboard)       N - 2027 KJELLER | \ |
 |_/_| Fax:   +47 63818146                               Norway |__|
(_____)-- E-mail: paalh@unik.no -- http://www.unik.no/~paalh --(_____)


