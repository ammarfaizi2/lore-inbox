Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313175AbSC1PCG>; Thu, 28 Mar 2002 10:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313176AbSC1PB4>; Thu, 28 Mar 2002 10:01:56 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:12298 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313175AbSC1PBn>; Thu, 28 Mar 2002 10:01:43 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15523.12369.210626.545285@laputa.namesys.com>
Date: Thu, 28 Mar 2002 18:01:37 +0300
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA32D9D.1EF59C5E@redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:
 > 
 > > Explicit initialization always leaves room for some "pad" field inserted
 > > by compiler for alignment to be left with garbage. This is more than
 > > just annoyance when structure is something that will be written to the
 > > disk. Reiserfs had such problems.
 > 
 > such compiler-based padding is architecture specific.. I'd hope the
 > reiserfs
 > on disk format isn't architecture specific ?

It is not.

 > 

Nikita.
