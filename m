Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTKCLfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 06:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTKCLfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 06:35:11 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:9094 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261797AbTKCLfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 06:35:04 -0500
Date: Mon, 3 Nov 2003 12:34:59 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel floating point emulation for big endian arm?
Message-Id: <20031103123459.6501b333.martin.zwickel@technotrend.de>
In-Reply-To: <20031103112050.A23136@flint.arm.linux.org.uk>
References: <20031103115134.63262f54.martin.zwickel@technotrend.de>
	<20031103112050.A23136@flint.arm.linux.org.uk>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.6claws65 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.0-test4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__3_Nov_2003_12_34_59_+0100_dJOGzzpqAVa5DT81"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__3_Nov_2003_12_34_59_+0100_dJOGzzpqAVa5DT81
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2003 11:20:50 +0000
Russell King <rmk+lkml@arm.linux.org.uk> bubbled:

> On Mon, Nov 03, 2003 at 11:51:34AM +0100, Martin Zwickel wrote:
> > Hi there!
> > 
> > Is there a working version of kernel floating point emulation for big endian
> > arm?
> > 
> > The version I currently use is 2.4.21-pre5 and fp emu doesn't work
> > correctly I think.
> 
> nwfpe is correctly implemented for big endian.  Most likely is that
> your library doesn't know how to crrectly handle the ARM floating
> point implementation.
> 
> You might also consider taking this to the linux-arm mailing list
> at lists.arm.linux.org.uk.
> 

Ah, ok.
I'll subscribe to the arm linux list. Sorry for the noise!

Regards,
Martin


-- 
MyExcuse:
It's union rules. There's nothing we can do about it. Sorry.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Mon__3_Nov_2003_12_34_59_+0100_dJOGzzpqAVa5DT81
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pj1jmjLYGS7fcG0RAmCdAJ4ixrXeBS8gpJzfox1ALkU3oPn3cwCfRHdn
j3SjuuuGOwvZaJZ8o7ozDl4=
=+SwH
-----END PGP SIGNATURE-----

--Signature=_Mon__3_Nov_2003_12_34_59_+0100_dJOGzzpqAVa5DT81--
