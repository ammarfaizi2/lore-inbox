Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTAODIG>; Tue, 14 Jan 2003 22:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTAODIG>; Tue, 14 Jan 2003 22:08:06 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:11956 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S261354AbTAODIG> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 22:08:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] contest benchmark v0.60
Date: Wed, 15 Jan 2003 14:16:48 +1100
User-Agent: KMail/1.4.3
Cc: Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>,
       Cliff White <cliffw@osdl.org>
References: <1042500483.3e234b8335def@kolivas.net>
In-Reply-To: <1042500483.3e234b8335def@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301151416.54557.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ok some mildly annoying bugs have already shown up in this release.

I've put up a contest-0.61pre on the contest website that addresses the one 
which ruins the results and has some of the changes going into 0.61

http://contest.kolivas.net

Major problem is that you need to run make oldconfig and make dep manually 
before running contest successfully the first time. This will be corrected by 
the time 0.61 comes out (probably by weekend).

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+JNKiF6dfvkL3i1gRAssdAJ0TRiDhbQUP3lcgTV86/iqS6SfdfgCeNI1d
t73yXAn48I+8j+w/l2ieDT0=
=TqgD
-----END PGP SIGNATURE-----
