Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVJONYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVJONYN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 09:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVJONYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 09:24:13 -0400
Received: from mail02.solnet.ch ([212.101.4.136]:30697 "EHLO mail02.solnet.ch")
	by vger.kernel.org with ESMTP id S1751141AbVJONYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 09:24:11 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: documentation? (i learned something today ;-) )
Date: Sat, 15 Oct 2005 15:23:58 +0200
User-Agent: KMail/1.8.3
Cc: Lee Revell <rlrevell@joe-job.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe> <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2694688.Kpf2JiGsf0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510151524.02123.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2694688.Kpf2JiGsf0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi all,

Le Saturday 15 October 2005 09:48, Anton Altaparmakov a =E9crit=A0:
 | If it has sysrq compiled in as root just do:
 |
 | echo s > /proc/sysrq-trigger
 | echo u > /proc/sysre-trigger
 | echo s > /proc/sysrq-trigger
 | echo b > /proc/sysrq-trigger
 |
 | This will "sync", "umount/remount read-only", "sync", "immediate
 | hardware reboot". =A0Should always work...

i'm impressed that i see that sysrq also works from procfs.... the=20
"PrintScreen/SysRq" button on my keyboard from time to time does not work=20
(old keyboard) and then it's pain hitting this key if you have to.=20

great news that you can also pass sysrq requests using proc - i've learned=
=20
something today... is this documented somewhere? maybe i'm bad in=20
reading/finding docs but i think i'm not the only one here. can somebody=20
point me to the links of docs where all this magic is specified? if not,=20
i will try to start my own docs on how to use the linux kernel magic.=20
mainly a collection of tricks like this and similar ones.=20

thank you in advance + greetings,
Damir

=2D-=20
  Customer: (angrily) "You said I would get 98 windows with this computer.=
=20
Where are they?"=20

--nextPart2694688.Kpf2JiGsf0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDUQLyPABWKV6NProRAnYJAJsGag/pV7AX0/deq9+7LoNnc0auNgCgooBQ
dtDD4Oi9RKJDVEpQ9bgVuPI=
=yC4b
-----END PGP SIGNATURE-----

--nextPart2694688.Kpf2JiGsf0--
