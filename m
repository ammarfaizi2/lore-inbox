Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267976AbTBMGmj>; Thu, 13 Feb 2003 01:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbTBMGmj>; Thu, 13 Feb 2003 01:42:39 -0500
Received: from mithra.wirex.com ([65.102.14.2]:62478 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S267976AbTBMGmh>;
	Thu, 13 Feb 2003 01:42:37 -0500
Message-ID: <3E4B40A2.70509@wirex.com>
Date: Wed, 12 Feb 2003 22:52:18 -0800
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org,
       Linux Security Module <linux-security-module@wirex.com>
Subject: Re: What went wrong with LSM, was: Re: [BK PATCH] LSM changes for
   2.5.59
References: <Pine.LNX.4.44.0302131014010.2621-100000@blackbird.intercode.com.au> <mailman.1045110181.1643.linux-kernel2news@redhat.com> <200302130512.h1D5CY909638@devserv.devel.redhat.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enig1AEF42F56837A86C1104196A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1AEF42F56837A86C1104196A
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pete Zaitcev wrote:

>I used to be super irritated by separate lists. Now I'm a member
>of linux-usb-devel, uml-devel, sparclinux, and god knows what else.
>Yes, they are unavoidable. Still, it is important to keep linux-kernel
>at least somewhat informed. IMHO.
>
LKML was kept at least somewhat informed, IMHO:

    * LSM announced April 11, 2001
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=98695004126478&w=4>
    * Should there be separate lists for module development?
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=98695659813419&w=4>
          o Probably
            <http://marc.theaimsgroup.com/?l=linux-kernel&m=98701977623500&w=4>
    * Discussion of the "DAC-out" design option appears in LKML July 12,
      2001
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=99497020101496&w=4>
    * LSM entangled in discussion of whether binary-only modules should
      be permitted, September 24, 2001
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=100134989121896&w=4>
    * Syscall 223 provisionally reserved for LSM
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=100255709403906&w=4>
    * LSM mentioned as related to extended attributes project
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=100509197600341&w=4>
    * Does LSM conflict with accessfs? January 16, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=101120760212957&w=4>
          o No, it does not
            <http://marc.theaimsgroup.com/?l=linux-kernel&m=101138310816232&w=4>
    * LSM in Guillaume's big list of 2.5 stuff, January 23, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=101176727007672&w=4>
    * LSM in Marc-Christian Petersen's forked kernel, May 21, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=102201919806027&w=4>
    * LSM interfacing to extended attributes, June 28, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=102527059400830&w=4>
    * First LSM patch into Linus' tree, July 16, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=102677797911383&w=4>
          o There are lots of these subsequently, so I won't cite them all
    * Racing with module load/unload affects LSM too, September 12, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=103181033207587&w=4>
    * HCH takes issue with LSM, September 26, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=103307580006067&w=4>
    * LSM hook style changes from low-cost hooks to no-cost configurable
      hooks, October 16, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=103472694817532&w=4>
    * LSM and GPL requirement for modules, October 17, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=103486544115996&w=4>
    * Remove the LSM sys_security call, October 17, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=103488104604175&w=4>
    * LSM changed so that module does not have to provision every hook
      by providing a default action, December 1, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=103872797618899&w=4>
    * The start of this flame-war, February 5, 2002
      <http://marc.theaimsgroup.com/?l=linux-kernel&m=104441899708408&w=4>

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                             http://wirex.com/~crispin/
Recruiting for Linux kernel and glibc developers:  http://immunix.org/jobs.html


--------------enig1AEF42F56837A86C1104196A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+S0Cp5ZkfjX2CNDARAe0nAJ9ixUs7kUpZrQ7Xj0tBtC0L/nlVagCdHvDh
S6qybwjd1ft7VerjP+ZXvmk=
=g8Z9
-----END PGP SIGNATURE-----

--------------enig1AEF42F56837A86C1104196A--

