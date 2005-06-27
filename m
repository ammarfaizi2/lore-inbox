Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVF0S0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVF0S0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVF0S0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:26:41 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:3342 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261569AbVF0SZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:25:19 -0400
Message-ID: <42C0448A.6070802@slaphack.com>
Date: Mon, 27 Jun 2005 13:25:14 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu> <42BF8F42.7030308@slaphack.com> <200506270541.j5R5fULX007282@turing-police.cc.vt.edu> <42BF9562.4090602@slaphack.com> <200506270612.j5R6CZGX008462@turing-police.cc.vt.edu> <42BF9C4D.3080800@slaphack.com> <200506270643.j5R6hqRh009781@turing-police.cc.vt.edu>            <42BFA421.70506@slaphack.com> <200506271640.j5RGefRQ018912@turing-police.cc.vt.edu>
In-Reply-To: <200506271640.j5RGefRQ018912@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 27 Jun 2005 02:00:49 CDT, David Masover said:
> 
> 
>>>>Speaking of backup, that's another nice place for a plugin.  Imagine a
>>>>dump that didn't have to be of the entire FS, but rather an arbitrary
>>>>tree...  That might be a nice new archive format.  I know Apple already
>>>>uses something like this for their dmg packages.
>>>
>>>Hmm.. you mean like 'tar' or 'cpio' or 'pax' or 'rsync'? :) 
>>
>>No, a dmg is an OS X program installer.  It appears to be a disk image
>>of sorts.  So this is the backup idea in reverse.
> 
> 
> I was addressing the ability to deal with an arbitrary tree.  By that definition,
> a dmg, being a disk image and not a tree image, is *not* what you want....

Not exactly what I want, no.

I was just trying to avoid the "people will never adopt a new archive
format" argument by pointing out that a similar archive format was
recently created and adopted.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsBEingHNmZLgCUhAQLTCw//XdrVgjaxvz9jzbiiSXVY60ItW5aechNV
JdvHBf1edVOCHs6OLil/cioK4Pjsfw3pKU+aBLN+eroS0RDomQkrqcy2zmFQ5JW6
oFJQEnb/uA95AhFtdCrbOF3rKABfJNo0TjwsRBuKyiabpYTGjfTJ0gDaQGAtBoOb
JmycKjZlJxhQgef9Q3LhG6UQaszCQrKX++pakKYaqOlughIpZ4O2AJTQWEq5ujdu
N9GNtO2DGd2sumWdxNpb0KSISZIs6PmPVthPsHwOvD0E6533q9a2AJH49j8AcuOz
1FCU7oFtpm994lwvc4G7eubRMbJ5Xgyy+suqfhTbumOgKzzBw8cKgpxkXFlcyDte
4WyNUlyIqAn0n9GAEVHWSDZ+vqN3E1u+bgLWJq0PEJJSjv9dJzhtH1WPu1bDA2v2
s1qNQDQromF+VfE1QF/fhy1Ttpqh7xAjBmxdxi+g3OU6Vlij7/j0fpMurIELknI0
MRFmw63TzMnFB07Vwi00L7ZR8GKSWDT0/smYF8R1V7stRqrAxHKDlT6E526ESMv+
ALa2pa1lGKWyCSgBMwPC0Cm9FBcOfaqxi60/5KE+bQOQc3Yc+20HCH5BIIQcNgWq
axOUO4txg9uz0GxfuvHWaa2tKE1vpbNO0Oy92QqdpCRmssyTNxs7EyhmdUB92Xar
SZVTSjpEmv0=
=WLzu
-----END PGP SIGNATURE-----
