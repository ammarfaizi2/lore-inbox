Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTLEN5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 08:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTLEN5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 08:57:52 -0500
Received: from chello062179052249.chello.pl ([62.179.52.249]:9423 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S264127AbTLEN5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 08:57:50 -0500
Date: Fri, 5 Dec 2003 15:04:17 +0100 (CET)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Bob <recbo@nishanet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Tomasz Rola <rtomek@cis.com.pl>
Subject: Re: The x Bit Problem
In-Reply-To: <Pine.LNX.3.96.1031205132520.5069F-100000@pioneer.space.nemesis.pl>
Message-ID: <Pine.LNX.3.96.1031205150118.5069G-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 5 Dec 2003, Tomasz Rola wrote:

> On Fri, 5 Dec 2003, Bob wrote:
> 
> > Windows doesn't just ignore it. When I move
> > files from win to linux all the x bits are turned
> > on so txt and bz2 and jpg files are marked
> > executable. That's annoying and a security
> > risk.
> 
> I'm jumping into this thread so this might have already been told but how
> about umask=0111 mount option for dos (fat,vfat etc) filesystems? Also,

And I'm answering to myself.

Nope. But with showexec=no it seems that only dirs and *.exe are x-ed.
Writing faster than light isn't good because humans think slower than
light...

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBP9CQaRETUsyL9vbiEQKkqACcCpWkZIqg2eFKCaHkCrQdKvLIRS8Anixh
8Lzl3FOsuEgy9FvFS0lPoqLI
=rTu8
-----END PGP SIGNATURE-----


