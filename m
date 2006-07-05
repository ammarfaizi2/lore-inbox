Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWGEEUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWGEEUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 00:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGEEUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 00:20:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:44263 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932453AbWGEEUv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 00:20:51 -0400
Message-Id: <200607050420.k654KPeU011979@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Con Kolivas <kernel@kolivas.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
In-Reply-To: Your message of "Wed, 05 Jul 2006 11:33:42 +1000."
             <200607051133.42595.kernel@kolivas.org>
From: Valdis.Kletnieks@vt.edu
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <200607051044.05257.kernel@kolivas.org> <44AB1294.6070600@bigpond.net.au>
            <200607051133.42595.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152073224_10982P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Jul 2006 00:20:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152073224_10982P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Jul 2006 11:33:42 +1000, Con Kolivas said:
> On Wednesday 05 July 2006 11:15, Peter Williams wrote:
> > Con Kolivas wrote:

> > >> +			 * don't let them adversely effect tasks on the expired
> > >
> > > ok I'm going to risk a lart and say "affect" ?

No, that would be correct English.

> > I have to refer you to the Oxford English Dictionary.

Actually, something like Strunk&White's "Elements of Style" is better suited
to this sort of thing than the OED.  The OED just lists *words*, not how to
put them together.

http://www.amazon.com/gp/product/020530902X/qid=1152072733/sr=1-1/ref=sr_1_1/002-2430423-3716834?s=books&v=glance&n=283155

> I was hoping you would.

They would *affect* tasks. The *effect* of this would be...

Note that 'effect' can be a verb too, but in that sense it refers to
a "facilitator" - "The mayor effected change in policy" meaning that he
made it happen. So in the kernel, "A effects B" is only correct if A
is code that is intended to make B happen.  If A, through blind all-elbows
coding, happens to cause B to change, then "A affects B" is proper.

Clear as mud? :)  If not, read the Strunk&White explanation of this one. :)

--==_Exmh_1152073224_10982P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqz4IcC3lWbTT17ARAqOSAKDAM+Luad35KLrBy25CzT3UfxP8/wCfcD8F
CEqxtIAP+0E6kbzp3aNPMKI=
=9ElW
-----END PGP SIGNATURE-----

--==_Exmh_1152073224_10982P--
