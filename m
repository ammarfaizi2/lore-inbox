Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWEUTbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWEUTbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWEUTbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:31:53 -0400
Received: from server12.vnpages.net ([72.37.174.242]:18369 "EHLO
	server12.vnpages.net") by vger.kernel.org with ESMTP
	id S1751553AbWEUTbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:31:52 -0400
From: Pau Garcia i Quiles <pgquiles@elpauer.org>
To: linux-kernel@vger.kernel.org
Subject: [IDEA] Poor man's UPS
Date: Sun, 21 May 2006 21:31:30 +0200
User-Agent: KMail/1.9.1
X-Face: "P|E1nv~?t.fk[R*p~~4\laG9kwhW$z&-BC*{V('kv[(?rNb\ZIVU>"=?utf-8?q?+=3B*m9d=3DLU8Q-X+k=0A=09Jxa=3FC=24=5FV1lhm1=5D=5C=5CaBG=24cb?=
 =?utf-8?q?4RS?=(:kVw~6yDw(j]8!K$,X@\YdgBd*m;Qa^^QL}@zu0"
 =?utf-8?q?taa5=0A=09w=7Cxwv+GCyN?=)Z7KBZ$65R`&N(7{+A?z?(XzdFQTI^J2O&25E^d./,V(G&E)=?Iv:ic8J>
 =?utf-8?q?9=3A=0A=09SwRMvl=3A=60*6?=)K.bdM17.:@phu&qWW|S{#P]$xlY#^c:2=Gga~<[VVAAW$%z4L-)`Ei,
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605212131.47860.pgquiles@elpauer.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server12.vnpages.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - elpauer.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

This is an idea a had some time ago. It might be a waste of time or it might 
be a good idea, you decide.

A short description would be "continuous system hibernation". Say you are 
running Firefox, writing an e-mail in mutt and compiling the next X.org 
release. The power goes off, your computer crashes or something happens and 
you lose everything you were doing (yes, sadly you haved saved your e-mail as 
a draft yet).

The "continuous hibernation" is some kind of memory snapshots taken, say, 
every 5 minutes. The next time your system starts after a crash, it'd say "oh 
oh, looks like something went wrong" and offer you a list of the last N (for 
instance, 4) snapshots and you can recover your system to the very same state 
it was before power went off or your dog unplugged your CPU. It might even 
ask you which individual applications you want to start from that snapshot:  
maybe you don't want to start Quake 3.

Provided the implementation is fast enough and you have a large hard drive, it 
might even allow you to say: "I want to restore the system to the same stage 
it had on Monday, 11.04PM"

That's it. Please, shoot at the idea not at the idealist :-)

- -- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to the amount of work, I usually need 10 days to answer)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEcMAj/DzYv9iGJzsRAnO9AKDwoybV6sdmPHmxe6poTTReW3ldOgCgr7jb
Qt47QlO6BVG14+o7rODhoNI=
=zoTu
-----END PGP SIGNATURE-----
