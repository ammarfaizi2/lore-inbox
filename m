Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUELAPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUELAPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbUELANW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:13:22 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23276 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263173AbUELAFW (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:05:22 -0400
Message-Id: <200405120005.i4C05HE8004375@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK) 
In-Reply-To: Your message of "Tue, 11 May 2004 16:50:13 PDT."
             <20040511165013.08ef86cd.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.3.96.1040511121328.16430C-100000@gatekeeper.tmr.com> <200405120127.33391.bzolnier@elka.pw.edu.pl>
            <20040511165013.08ef86cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-468697820P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 20:05:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-468697820P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2004 16:50:13 PDT, Andrew Morton said:

> And RHL is shipping now with 4k stacks, so presumably any disasters
> are relatively uncommon...

I think currently, it's only the people running the -test or -devel Fedora
trees that can get bit - Fedora Core 1 didn't have it, as it was still a
2.4 kernel, and Fedora Core 2 just kicked over from FC 1.92 last night..

And then they'd have to have NVidia cards, and use the NVIdia drivers..

and I suspect that most of the people who are in that group visit either
one of the NVidia forums or www.minion.de, both of which have lots
of tags saying that patch needs reverting...

So right now it's probably NOT biting too many, as only the clueful are
getting into a situation where it's a problem.

Wait a week or two, when .ISO's of FC2 hit the streets. :)

--==_Exmh_-468697820P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoWo8cC3lWbTT17ARAuUKAJ4iaCuhwmXjvXLztldrG//F3sdm/gCfXMR7
p9+A/RmFogMgNDpovHolK00=
=N6Ke
-----END PGP SIGNATURE-----

--==_Exmh_-468697820P--
