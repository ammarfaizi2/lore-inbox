Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUBXIop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUBXIop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:44:45 -0500
Received: from terra.irts.fr ([194.206.161.9]:11459 "EHLO ns1.terranet.fr")
	by vger.kernel.org with ESMTP id S262215AbUBXIof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:44:35 -0500
Message-ID: <403B0E92.60903@laposte.net>
Date: Tue, 24 Feb 2004 09:42:58 +0100
From: MALET JL <malet.jean-luc@laposte.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.5) Gecko/20031007
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Chris Lingard <chris@ukpost.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux 2.6.3] [gcc 3.3.3] compile errors
References: <403911B3.10601@laposte.net> <20040223074221.5f711665.rddunlap@osdl.org> <403A2ADB.9040002@laposte.net> <200402231658.53516.chris@ukpost.com>
In-Reply-To: <200402231658.53516.chris@ukpost.com>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF653E2B56BA70722D3A5AB98"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF653E2B56BA70722D3A5AB98
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Chris Lingard a écrit :

>On Monday 23 February 2004 4:31 pm, MALET JL wrote:
>
>  
>
>>copy from /usr/src/linux/include/asm to /usr/include/asm
>>copy from /usr/src/linux/include/asm-generic to /usr/include/asm-generic
>>copy from /usr/src/linux/include/linux to /usr/include/linux
>>
>>is this wrong ? I've done this all the time (since 2.4.2 kernel) without
>>problem..... if i'm wrong please correct my behaviour
>>    
>>
>
>You should use the kernel headers to build glibc; and sanitised headers
>such as RedHat's or http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
>to build the rest of the system.  Suggest you follow www.linuxfromscratch.org 
>for further details.
>
>Chris
>  
>
O_O! question what is the purpose of having two set of headers? do you 
think this is good work to provide a unsable set of headers with a 
software? why not include the RedHat's one then......

--------------enigF653E2B56BA70722D3A5AB98
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAOw6Zcl3j/qUaL14RAqr1AJ9W0WdwHtTsNTyq43fvmu1VUus1pgCeK5mT
g1irtDM2koCq3IuDJ+ZpXlA=
=gs/V
-----END PGP SIGNATURE-----

--------------enigF653E2B56BA70722D3A5AB98--

