Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270698AbTGNRJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270731AbTGNRIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:08:19 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:9618 "HELO
	ns0.eris.dera.gov.uk") by vger.kernel.org with SMTP id S270698AbTGNRDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:03:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Antonio Vargas <wind@cocodriloo.com>
Subject: Re: requirements for installing a 2.6.0-test kernel....
Date: Mon, 14 Jul 2003 18:17:07 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200307141659.05451.m.watts@eris.qinetiq.com> <20030714163749.GC2684@wind.cocodriloo.com>
In-Reply-To: <20030714163749.GC2684@wind.cocodriloo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307141817.07524.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Sure - I'm trying it on Mandrake 9.1

I've already had fun with the module_init_tools from 
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

Basically after doing the ./configure --prefix=/ && make moveold, I was left 
with a bunch of dangling symlinks in /sbin

I've since grabed the src.rpm from here: 
http://people.redhat.com/arjanv/2.5/SRPMS/
and that seems to be behaving a bit more (although I haven't rebooted yet :)

Everything else is from a standard Mandrake 9.1 install, so I'm using gcc 
3.2.2 and associated gubbins.

Mark

> On Mon, Jul 14, 2003 at 04:59:05PM +0100, Mark Watts wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> >
> > Now that 2.6.0-test is out, can someone point me at the definative
> > instrictions for compiling and booting a 2.6.x kernel?
> >
> > I understand that the compile process has changed since 2.4.x, and I may
> > also need some updated module related things.
> >
> > This doesnt have to be a handholding guide, just a quick
> > rundown/qhecklist will do.
>
> Mark, I'm also interested on this, and also willing to install
> a recent distro on purpose. Would you mind if we shared install
> experiences?
>
> Planning to download suse from ftp to do a network install at the moment.
> Will probably compile 2.6.0-test1 meanwhile :)
>
> Greets, Antonio.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/EuWTBn4EFUVUIO0RAscbAKDJsPogTT2PhQS89xeyJbEQxxz2UwCeKtkE
t8xmlw6J4uJb+nINOcGOnGE=
=Jv+e
-----END PGP SIGNATURE-----

