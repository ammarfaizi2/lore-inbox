Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTEMSDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTEMSCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:02:07 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:48849 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263311AbTEMSAR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:00:17 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: vda@port.imtp.ilyichevsk.odessa.ua, Con Kolivas <kernel@kolivas.org>
Subject: Re: [2.420] Unexplained repeatable Oops
Date: Tue, 13 May 2003 20:13:39 +0200
User-Agent: KMail/1.5.1
References: <200305112052.51938.devilkin-lkml@blindguardian.org> <200305120721.43384.devilkin-lkml@blindguardian.org> <200305131322.h4DDMSu31637@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200305131322.h4DDMSu31637@Port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Torrey Hoffman <thoffman@arnor.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305132013.46118.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 13 May 2003 15:29, Denis Vlasenko wrote:
> On 12 May 2003 08:21, DevilKin wrote:
> > > Good old VIA chipset. I solved a similar problem by underclocking a
> > > cpu on a similar chipset :-(
> > >
> > > Try the mprime client stress test to ensure your hardware is ok.
> > > www.mersenne.org
> >
> > Ah.
> > Strange thing is that it has worked perfectly for atleast a year,
> > problems only started yesterday morning while I was doing what I've
> > done a zillion times before...
>
> Maybe your AGP card, RAM or mobo AGP chipset is not healthy anymore.
> Cosmic rays etc. 8(

Bah.

Memtest86 gives for both RAM dimms the same problem on the same address. 
I think that 1. both chips are fried, or 2. the bus is fried. I will test the DIMMS in another 
system to make sure.

Thanks for the answers sofar.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wTXWpuyeqyCEh60RAoZSAJ45Gg14HD+E5dlVVMqF3eM/o5pPBQCeNjIg
lL3wx/pvuihyI0eEDnxtasA=
=pXRc
-----END PGP SIGNATURE-----

