Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156217AbPIPP5g>; Thu, 16 Sep 1999 11:57:36 -0400
Received: by vger.rutgers.edu id <S156152AbPIPP52>; Thu, 16 Sep 1999 11:57:28 -0400
Received: from kleopatra.acc.umu.se ([130.239.18.150]:47908 "EHLO kleopatra.acc.umu.se") by vger.rutgers.edu with ESMTP id <S156196AbPIPP4z>; Thu, 16 Sep 1999 11:56:55 -0400
Date: Thu, 16 Sep 1999 17:56:41 +0200 (MET_DST)
From: David Weinehall <tao@acc.umu.se>
To: Linux Kernel Developer Mailing-list  <linux-kernel@vger.rutgers.edu>
Subject: [Announcement] CBMFS v0.4e
Message-ID: <Pine.A41.4.10.9909161626420.9040-100000@kleopatra.acc.umu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

For anyone interested, I've just put a unified diff patch with
CBMFS v0.4e on my homepage. This one should work, as opposed to my
previous v0.4's... It compiles without warnings (thus it's good), the
computer boots with it compiled into the kernel (thus it's better) and the
filesystem mounts and doesn't oops on cp/ls etc. (thus it's perfect)

Autodetection works (at least for the disk-images I've tried), and the
birds are singing outside my window (ok, that's a lie.)

http://www.acc.umu.se/~tao/

Look under [Linux related], subsection patches.


/David
  _                                                                 _ 
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky // 
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </ 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
