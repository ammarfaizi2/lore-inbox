Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUF0TaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUF0TaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUF0TaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:30:16 -0400
Received: from mout2.freenet.de ([194.97.50.155]:48357 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S262060AbUF0TaL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:30:11 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Sun, 27 Jun 2004 21:28:54 +0200
User-Agent: KMail/1.6.2
References: <200406251840.46577.mbuesch@freenet.de> <200406261929.35950.mbuesch@freenet.de> <1088363821.1698.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1088363821.1698.1.camel@teapot.felipe-alfaro.com>
Cc: kernel@kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Willy Tarreau <willy@w.ods.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406272128.57367.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>:
> On Sat, 2004-06-26 at 19:29 +0200, Michael Buesch wrote:
> 
> > Now another "problem":
> > Maybe it's because I'm tired, but it seems like
> > your fix-patch made moving windows in X11 is less smooth.
> > I wanted to mention it, just in case there's some other
> > person, who sees this behaviour, too. In case I'm the
> > only one seeing it, you may forget it. ;)
> 
> I can see the same with 7.4-1 (that's 2.6.7-ck2 plus the fix-patch): X11
> feels sluggish while moving windows around. Simply by loading a Web page
> into Konqueror and dragging Evolution over it, makes me able to
> reproduce this problem.
> 
> Doing the same on 2.6.7-mm3 is totally smooth, however.

I think staircase-7.7 fixed this, too. (for me).
Have a try.

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3x/2FGK1OIvVOP4RAnxTAJ9NUM6V1bccFgAauHx6sV6+80DjLQCg1hE8
c2krr3+fW/notHs8mc8it48=
=OQoZ
-----END PGP SIGNATURE-----
