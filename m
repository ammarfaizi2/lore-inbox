Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbUBATlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 14:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUBATlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 14:41:49 -0500
Received: from server19.glai.de ([80.239.154.135]:23681 "EHLO server19.glai.de")
	by vger.kernel.org with ESMTP id S265078AbUBATlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 14:41:44 -0500
Date: Sun, 1 Feb 2004 20:40:45 +0100
From: markus reichelt <mr@lists.notified.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
Message-ID: <20040201194045.GA2372@lists.notified.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4006C665.3065DFA1@users.sourceforge.net> <Xine.LNX.4.44.0401151315520.16587-100000@thoron.boston.redhat.com> <20040201171928.GG1254@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; x-action=pgp-signed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040201171928.GG1254@edu.joroinen.fi>
Organization: still stuck in reorganization mode
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pasi Kärkkäinen <pasik@iki.fi> wrote:
> http://www.tcs.hut.fi/~mjos/doc/herring061103.pdf
> 
> That PDF by Markku-Juhani O. Saarinen discusses about these vulnerabilities,
> and has one solution to them.

Interesting... Do you happen to know where one can get hold of that patch he
mentioned?

I'd like to try it out with the recent 2.6.2-rc3 kernel.

- -- 
Bastard Administrator in $hell
GPG-Key at http://lists.notified.de/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAHVY8LMyTO8Kj/uQRAsL3AJwKgmWs1nFx2dyGJvD0LN/1RcMOAQCfUrev
UkVCitUNB2wdW+v6EdlTxHQ=
=As2+
-----END PGP SIGNATURE-----
