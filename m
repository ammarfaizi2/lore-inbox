Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTFYPvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTFYPvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:51:52 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:32521 "HELO
	ns0.eris.dera.gov.uk") by vger.kernel.org with SMTP id S264601AbTFYPvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:51:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: Finding out what cards a driver supports...
Date: Wed, 25 Jun 2003 16:58:35 +0100
User-Agent: KMail/1.4.3
References: <200306251453.02690.m.watts@eris.qinetiq.com> <20030625143239.GA11244@gtf.org>
In-Reply-To: <20030625143239.GA11244@gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306251658.35745.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Wed, Jun 25, 2003 at 02:53:02PM +0100, Mark Watts wrote:
> > How would I find out what network cards a particular driver supports?
> > (particularly the tg3 / bcm5700 driver in 2.4.x)
>
> Look in the PCI ids table, and compare that with the output of 'lspci -n'
> for your card.
>
> 	Jeff

Is there a way to do it without actually having the card in question?

I'm trying to help a chap who has a 3Com 3c940 GigE card...

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE++carBn4EFUVUIO0RAjqdAKCzOtOMKBrkdGVDa0YJa/FE90g4PgCgxIp7
BvEkaHMTOLFbp7f6BROTGOM=
=yX3c
-----END PGP SIGNATURE-----

