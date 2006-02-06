Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWBFFrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWBFFrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 00:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWBFFrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 00:47:04 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:41687 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751000AbWBFFrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 00:47:03 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 6 Feb 2006 15:43:37 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602061402.54486.nigel@suspend2.net> <1139200499.2791.210.camel@mindpipe>
In-Reply-To: <1139200499.2791.210.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3587314.fEtem6I80N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602061543.42174.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3587314.fEtem6I80N
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 06 February 2006 14:34, Lee Revell wrote:
> On Mon, 2006-02-06 at 14:02 +1000, Nigel Cunningham wrote:
> > (they now have to download extra
> > libraries to use the splashscreen, which were not required with the
> > bootsplash patch, and need to check whether an update to the userui
> > code
> > is required when updating the kernel)
>
> You could have avoided this problem by keeping the userspace<->kernel
> interface stable.

True, but sometimes you need to make changes that do modify the interface.=
=20
If the interface involves more functionality, this will happen more=20
frequently.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart3587314.fEtem6I80N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5uION0y+n1M3mo0RAp+UAJ41JIixTUOQOjp9PgU4cHLv5Hc+xACfZAwx
0cph5VDPmcFaM/4sBB039K0=
=G0YK
-----END PGP SIGNATURE-----

--nextPart3587314.fEtem6I80N--
