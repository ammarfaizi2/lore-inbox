Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTF1Nuk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 09:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTF1Nuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 09:50:40 -0400
Received: from mail47-s.fg.online.no ([148.122.161.47]:9154 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP id S265209AbTF1Nuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 09:50:39 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Subject: Re: TCP send behaviour leads to cable modem woes
Date: Sat, 28 Jun 2003 16:04:51 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306272020.57502.svein.ove@aas.no> <200306272145.22008.svein.ove@aas.no> <1056743877.681.5.camel@hades>
In-Reply-To: <1056743877.681.5.camel@hades>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306281604.52876.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

fredag 27. juni 2003, 21:57, skrev Mika Liljeberg:
> On Fri, 2003-06-27 at 22:45, Svein Ove Aas wrote:
> > Incidentally, while googling I heard someone saying that only works if
> > it's enabled on both ends? Of course, that might be if upload/download
> > are 'both' affected, in which case it wouldn't apply to me.
>
> It's a sender side only algorithm, so enabling it at your end should be
> enough to help the uploads. For downloads it needs to be on at the other
> end, of course.

Well, it doesn't appear to have any effect.
(What is it *supposed* to do? Something about spurious retransmission 
timeouts, was it?)

I'm going to research this a bit more on my own, if none of you have any 
further ideas. If I find a solution it should probably be in a HOWTO 
somewhere, so I'll get back to you if/when that happens.

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/aCD9OlFkai3rMARAtzFAKCyfXKjWF9yA6wuQZiJvo11RsIs9gCcCBW/
Si1UTkOPaDEtXz5Pq+U64NM=
=kjUX
-----END PGP SIGNATURE-----

