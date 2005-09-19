Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVISF6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVISF6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVISF6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:58:49 -0400
Received: from h80ad253d.async.vt.edu ([128.173.37.61]:25483 "EHLO
	h80ad253d.async.vt.edu") by vger.kernel.org with ESMTP
	id S932322AbVISF6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:58:48 -0400
Message-Id: <200509190556.j8J5utH0024042@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Christian Iversen <chrivers@iversen-net.dk>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Your message of "Sun, 18 Sep 2005 22:16:11 PDT."
             <432E499B.7000003@namesys.com> 
From: Valdis.Kletnieks@vt.edu
References: <432AFB44.9060707@namesys.com> <200509181321.23211.vda@ilport.com.ua> <20050918102658.GB22210@infradead.org> <200509181406.25922.chrivers@iversen-net.dk>
            <432E499B.7000003@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127109414_2682P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 01:56:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127109414_2682P
Content-Type: text/plain; charset=us-ascii

On Sun, 18 Sep 2005 22:16:11 PDT, Hans Reiser said:

> Hellwig, people who write slow file systems should not lecture their
> measurably superiors on how to code.  Oh, and I should mention that
> other people besides me have measured reiser4, and concluded it is twice
> the speed of the other Linux filesystems, so don't go claiming it is
> just my benchmarks.   What you are doing is keeping me from doing a real
> code review myself by keeping my guys so busy that they don't have time
> to review the fixmes I inserted and would insert more of if I thought
> they had time for them.

Hans, unfortunately the most obvious reading of the above is "Reiser4 is so
damned fast because it doesn't bother doing sanity-checking".  If there's still
more "fixmes" to be inserted that *you* know of, and there are so many that
there's no time to fix them, why is this being submitted for inclusion?

On Sun, 18 Sep 2005 22:09:08 PDT, Hans Reiser said:
> Of course, the reiser4 code is not as stable as it was before the
> changes Christoph asked for.

This sort of claim requires proof - can you point at *specific* things that
were less stable after you fixed the code, including explaining why they're
less stable?

--==_Exmh_1127109414_2682P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDLlMmcC3lWbTT17ARAoI+AKCmzQSVJpcH0t+/LF7ihegfixcmJACePBRc
4x5F5HgNI/8rOcCnYmn9E7g=
=wtgW
-----END PGP SIGNATURE-----

--==_Exmh_1127109414_2682P--
