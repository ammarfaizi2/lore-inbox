Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265307AbTLNAIY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 19:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbTLNAIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 19:08:24 -0500
Received: from main.gmane.org ([80.91.224.249]:6328 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265307AbTLNAIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 19:08:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: 2.4 vs 2.6
Date: Sat, 13 Dec 2003 17:08:31 -0800
Message-ID: <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com>
References: <20031201062052.GA2022@frodo> <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
X-Spammers-Please: blackholeme@rychter.com
Cancel-Lock: sha1:h4Nf3ulctVxK+/idkRyaecRJNss=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Marcelo" == Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
[...]
 Marcelo> 2.6 is already stable enough for people to use it.

Yes, that's an old post I'm responding to, but I've just given 2.6 a try
on my desktop machine, and the above statement seems even more
annoying. I hit the following problems:

  -- I had to wrestle ATI drivers into compiling, they finally did, but
     the kernel prints scary-looking warnings with call stacks, about
     "sleeping function called from invalid context at mm/slab.c:1856,
  -- modules don't autoload for some reason (though I'm sure that could
     be solved),
  -- bttv does not compile, so no video input for me,
  -- drivers for my telephony card (from Digium) are not 2.6-ready, so
     no telephony support for me,
  -- I have just frozen the machine hard by copying files over NFS and
     doing a simulation write to an ATAPI CD-RW at the same time.

I haven't even gotten to VMware and user-mode Linux, which I also need,
and I'm not even dreaming about getting my scanner to work. Not to
mention that on my laptop there would be an entirely different set of
issues, and software suspend in 2.6 is, well, still lacking.

So, as for me, 2.6 is a definite no-no. I see no advantage whatsoever in
running it, it caused me nothing but pain, and there is no improvement
that I could see that would justify the upgrade.

So please be careful when making statements like that. 2.6 is *NOT*
stable enough nor ready enough for people to use it, unless those people
have a narrow range of hardware on which the 2.6 kernel has actually
been tested (translation: they have the same hardware as the main
developers do).

--J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/27gTLth4/7/QhDoRAoTEAJ0e8UPJFEBjNIWG5e4reBTIkg/8iACfSwKG
xzHSQjQMk4qTBg7jRLMctfs=
=ifut
-----END PGP SIGNATURE-----
--=-=-=--

