Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbREYUPV>; Fri, 25 May 2001 16:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261809AbREYUPB>; Fri, 25 May 2001 16:15:01 -0400
Received: from [200.192.207.142] ([200.192.207.142]:51471 "EHLO
	olimpo.networx.com.br") by vger.kernel.org with ESMTP
	id <S261808AbREYUO7> convert rfc822-to-8bit; Fri, 25 May 2001 16:14:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Thiago Vinhas de Moraes <tvinhas@networx.com.br>
Organization: Networx - A SuaCompanhia.com
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: The difference between Linus's kernel and Alan Cox's kernel
Date: Fri, 25 May 2001 17:12:39 -0300
X-Mailer: KMail [version 1.2]
In-Reply-To: <XFMail.010525213709.nemosoft@smcc.demon.nl> <3B0EB7A6.E0B17C79@mandrakesoft.com>
In-Reply-To: <3B0EB7A6.E0B17C79@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <01052517123904.01385@zeus.networx.com.br>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi.

Maybe lots of you already know the answer, maybe it's a really stupid 
question. If it is, please tell me. I'll not be offended.

Why there are two different kernel trees? There is always the official 
release, provided by Torvalds, and then Alan provides a patch merging Linus's 
stuff, and adding (?) tons of bug fixes.

Why aren't the -ac patches completely merged to the official tree, and you 
centralize the work on single kernel patches ?? Won't it be easier to 
administrate?

I'm so sorry if it's a really stupid question. It's because I never know what 
pre-patch to apply, the -ac* or the -pre*. In doubt, I apply Alan's, because 
it appears to be always Linus stuff, and more bug fixes, recently, the 
Linus's -pre* appears to have merges from the -ac on each release.
I just don't understand why it can all be merged.


Regards,
Thiago Vinhas de Moraes
NetWorx - A SuaCompanhia.com
Rio de Janeiro - Brazil
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Dry8GHuTR9LK9ocRAsIIAKCs/uMrlDxZSlst8J0h0D6k6tylkACeKNMB
ESyPHbcpcbxWr48NySQYUBs=
=FotG
-----END PGP SIGNATURE-----
