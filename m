Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282483AbRLFSfN>; Thu, 6 Dec 2001 13:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282489AbRLFSeO>; Thu, 6 Dec 2001 13:34:14 -0500
Received: from t2.redhat.com ([199.183.24.243]:6133 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S282491AbRLFSdt>; Thu, 6 Dec 2001 13:33:49 -0500
Date: Thu, 6 Dec 2001 12:33:42 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: m.loskot@chello.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange problem with 2.4.x kernel
Message-Id: <20011206123342.42179ed3.reynolds@redhat.com>
In-Reply-To: <20011206190454.B848@cheetah.chello.pl>
In-Reply-To: <20011206190454.B848@cheetah.chello.pl>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.HsyC3s(16+)nA8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.HsyC3s(16+)nA8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Uttered "Mateusz " <m.loskot@chello.pl>, spoke thus:

> Hello, 
> I'm writing first time to you, so let me say HELLO !
> 
> I installed Slackware 8.0 month ago, it is my firewall with NAT (iptables).
> I have two kernels: 2.2.19 and 2.4.5 - this is my default kernel.
> Everything went fine but three days ago I tried to compile some 2.4.x kernel (2.4.0, 2.4.4, 2.4.5, ...., 2.4.12, 2.4.16).
> I went to ftp.kernel.org and got some kernels (zipped and bzipped)
> (transfered in BINARY mode, not ASCII).
> So the problem is:
> When I tried to gunzip or bunzip2 any ftp'd kernel I got terrible ;) message:
> 
> invalid compressed data: CRC-ERROR 

You should validate the files you download before trying to use them.  Check the
information at:

	http://www.kernel.org/signature.html

for how to go about this.  

Use ftp(1) or wget(1) to do the downloads.  Do _not_ try to get the files using
any web browser, such as Netscape, because they are known to mangle files that
they don't understand.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- + -- -- -- -- -- -- -- -- -- --
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.HsyC3s(16+)nA8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjwPugoACgkQWEn3bOOMcuq20QCgrsMaFmek2B1cnH31bxqNyWVv
KgEAn2zKW406g+J+nE1PCk7EId1NRS8h
=OMrB
-----END PGP SIGNATURE-----

--=.HsyC3s(16+)nA8--

