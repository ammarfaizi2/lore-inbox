Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282867AbRK0Isz>; Tue, 27 Nov 2001 03:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282880AbRK0Isp>; Tue, 27 Nov 2001 03:48:45 -0500
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:18582 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id <S282879AbRK0Ish>; Tue, 27 Nov 2001 03:48:37 -0500
From: "Ahmed Masud" <masud@googgun.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, "'John Jasen'" <jjasen1@umbc.edu>
Cc: "'J Sloan'" <jjs@pobox.com>, <lgb@lgb.hu>,
        "'Arjan van de Ven'" <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Which gcc version?
Date: Tue, 27 Nov 2001 03:42:22 -0500
Message-ID: <000501c1771f$72f0cdc0$8604a8c0@googgun.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <E168QXg-00069p-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > That said, the versions in 7.1, and the patches available have
> > done  reasonably well for everything that I've tried to compile
> > (kernels  included).
> > 
> > What are they going to do about gcc 3.0.x? It'll be amusing 
> to watch.
> 
> Its shipped as an additional compiler as well. The only real 
> question now is how long before 3.x becomes really solid. 
> That should be in time for the next RH major update I hope

In case this is pertinent: I have been using gcc 3.0.2 since its
inception to compile the kernel on various CPUs (Pentium II, Pentium
III, AMD Athelon, and also the experimental stuff for PA/RISC 2.0)
and have not had any trouble with it.   Seems to be fairly solid and
trouble free.  RH has to get its act together though ... The gcc 2.96
and a kgcc for the kernel was just too hilarious and rather sad at
the same time.

Cheers.

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.3 for non-commercial use <http://www.pgp.com>

iQA/AwUBPANR7eA+WVFT6/r4EQK/OwCg+X2va7QIzbwDvRBv27Kf/AXmy3UAn1/h
AvFgqGDvS0iv7RQXMprUIJB8
=Hs5v
-----END PGP SIGNATURE-----

