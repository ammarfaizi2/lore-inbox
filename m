Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSJ2Sc4>; Tue, 29 Oct 2002 13:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbSJ2Sc4>; Tue, 29 Oct 2002 13:32:56 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:24083 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261875AbSJ2Scz>; Tue, 29 Oct 2002 13:32:55 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15806.54736.737949.328809@laputa.namesys.com>
Date: Tue, 29 Oct 2002 21:39:12 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [ANNOUNCE]: reiser4
In-Reply-To: <3DBED1C8.5080404@pobox.com>
References: <15806.51536.985203.709475@laputa.namesys.com>
	<3DBED1C8.5080404@pobox.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Microsoft: Programs so large they have weather.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
 > Nikita Danilov wrote:
 > 
 > >Hello,
 > >
 > >Snapshot of reiser4 source code can be found at 
 > >http://www.namesys.com/snapshots/2002.10.29/.
 > >
 > >It is set of patches against current Linus BK tree (2.5.44).
 > >  
 > >
 > 
 > The current Linus BK tree is quite a bit different from 2.5.44 ;-)
 > 
 > Take a look at 2.5.44-bk1 at 
 > ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/
 > 
 > A -bk2 snapshot should appear within the hour, too, with heaps of 
 > additional changes.
 > 

Sorry, my fault.

Patches in reiser4 snapshot are against Linus BK repository at
http://linux.bkbits.net/linux-2.5. Numbers 2, 5, and 44, are, of course,
just VERSION, PATCHLEVEL, and SUBLEVEL in the Makefile of the said
repository.

Probably we should prepare patches against ftp.kernel.org shapshots
instead.

 >     Jeff
 > 

Nikita.

 > 
 > 
 > 
