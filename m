Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262749AbTCYQXJ>; Tue, 25 Mar 2003 11:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262766AbTCYQXJ>; Tue, 25 Mar 2003 11:23:09 -0500
Received: from ns2.snowman.net ([66.93.83.121]:53258 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id <S262749AbTCYQXG>;
	Tue, 25 Mar 2003 11:23:06 -0500
Date: Tue, 25 Mar 2003 11:34:02 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Thomas Duffy <tduffy@afara.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030325163402.GO18434@ns.snowman.net>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Thomas Duffy <tduffy@afara.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1048183475.3427.112.camel@biznatch> <Pine.LNX.3.96.1030325110027.1437B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQyQLyduEnelPo/g"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030325110027.1437B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.20 (i686)
X-Uptime: 11:24:58 up 94 days, 11:36, 19 users,  load average: 0.25, 0.15, 0.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQyQLyduEnelPo/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Bill Davidsen (davidsen@tmr.com) wrote:
> On Thu, 20 Mar 2003, Thomas Duffy wrote:
>=20
> > On Thu, 2003-03-20 at 09:51, Eli Carter wrote:
> > > So, who can beat his 15.10 bogomips?
> >=20
[...]
> > bogomips        : 12.44
>=20
> At one point I ran Linux on a 386SX-16 with 12MB. That machine ran 1.2.13
> (IIRC) until Dec 31 1999, when I was afraid it was not Y2k hardened. I
> still see spam to glacial.tmr.com today. The name was NOT because it was
> so cool ;-)
>=20
> I may still have that board, but I'm not about to put it back in service
> to measure speed. Your firewall is the slowest "real machine" I've seen,
> emulation and embedded machines are not really general purpose.

If we're really curious...

sfrost@ns2:/home/sfrost> cat /proc/cpuinfo
processor       : 0
vendor_id       : unknown
cpu family      : 4
model           : 0
model name      : 486
stepping        : unknown
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : no
cpuid level     : -1
wp              : yes
flags           :
bogomips        : 9.42

This is my secondary name server.  This was also after an upgrade from
a 386 because bind9 is a bloody pig. :)  To be honest I've thought about
putting the 386 back in service as something else because unlike my web
server and primary name server there's no chance a CPU fan on it is
going to die causing a CPU to fry and the system to crash.  At one point
the 386 had a 630 day uptime, running 2.2.16.

	Stephen

--LQyQLyduEnelPo/g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gIT6rzgMPqB3kigRArFMAJ0YsxfZ0osDubVBbizfZD5REm/BVwCePfjY
pR2drgFMsU7UJ0d8rMvHyEk=
=ohaA
-----END PGP SIGNATURE-----

--LQyQLyduEnelPo/g--
