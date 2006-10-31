Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946028AbWJaV1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946028AbWJaV1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946030AbWJaV1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:27:17 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40161 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1946028AbWJaV1R (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:27:17 -0500
Message-Id: <200610312126.k9VLQtCB003616@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Dave Jones <davej@redhat.com>
Cc: ray-gmail@madrabbit.org, "Martin J. Bligh" <mbligh@google.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
In-Reply-To: Your message of "Tue, 31 Oct 2006 11:51:33 EST."
             <20061031165133.GB23354@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com>
            <20061031165133.GB23354@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1162330015_3157P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Oct 2006 16:26:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1162330015_3157P
Content-Type: text/plain; charset=us-ascii

On Tue, 31 Oct 2006 11:51:33 EST, Dave Jones said:
> On Tue, Oct 31, 2006 at 08:34:23AM -0800, Ray Lee wrote:
>  > On 10/31/06, Martin J. Bligh <mbligh@google.com> wrote:
>  > > > At some point we should get rid of all the "politeness" warnings, just
>  > > > because they can end up hiding the _real_ ones.
>  > >
>  > > Yay! Couldn't agree more. Does this mean you'll take patches for all the
>  > > uninitialized variable crap from gcc 4.x ?
>  > 
>  > What would be useful in the short term is a tool that shows only the
>  > new warnings that didn't exist in the last point release.
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/viro/remapper.git

As somebody proves me wrong on the fact it's not easy.  Of course, it's
Al's git tree, which is probably saying something. :)

--==_Exmh_1162330015_3157P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFR7+fcC3lWbTT17ARAstFAJ9e74iAUbEDuEKYutVnViYZXLPxzgCgvFAZ
a7nMUz31jfiGI/q9s84Gk3w=
=/MEl
-----END PGP SIGNATURE-----

--==_Exmh_1162330015_3157P--
