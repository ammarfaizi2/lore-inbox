Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTF0Tat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 15:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTF0Tat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 15:30:49 -0400
Received: from mail47-s.fg.online.no ([148.122.161.47]:19171 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP id S264728AbTF0Tas convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 15:30:48 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Subject: Re: TCP send behaviour leads to cable modem woes
Date: Fri, 27 Jun 2003 21:45:20 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306272020.57502.svein.ove@aas.no> <1056740526.645.2.camel@hades>
In-Reply-To: <1056740526.645.2.camel@hades>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306272145.22008.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

fredag 27. juni 2003, 21:02, skrev Mika Liljeberg:
> Try enabling tcp_frto on your Linux box to see if that helps the
> uploads.

I'm runing 2.4.20-gentoo at the moment, but I'll try that later.

Incidentally, while googling I heard someone saying that only works if it's 
enabled on both ends? Of course, that might be if upload/download are 'both' 
affected, in which case it wouldn't apply to me.

Well, I'll try it, anyway. Sounds interesting.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/J7Q9OlFkai3rMARAmYpAJ4mSwEONKs2h/8SC02pq/TTTs+1BgCfXaAu
ZNcnbYAm8Rl3BE87jB1Z8gY=
=Vlbk
-----END PGP SIGNATURE-----

