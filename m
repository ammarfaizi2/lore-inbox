Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271322AbTGQQjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271327AbTGQQjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:39:12 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:27405 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271322AbTGQQZT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:25:19 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: devfsd
Date: Thu, 17 Jul 2003 18:38:59 +0200
User-Agent: KMail/1.5.2
References: <20030715214610.GA21238@core.citynetwireless.net> <20030717165603.A8369@infradead.org>
In-Reply-To: <20030717165603.A8369@infradead.org>
Cc: Ro0tSiEgE LKML <lkml@ro0tsiege.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307171839.10951.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 17 July 2003 17:56, Christoph Hellwig wrote:
> On Tue, Jul 15, 2003 at 04:46:10PM -0500, Ro0tSiEgE LKML wrote:
> > Why is devfsd still tagged as EXPERIMENTAL even in 2.6.0-test1 ? Is
> > there something wrong with it, or has it just not been changed?
>
> It's still there because we don't have a BROKEN tag.

Hm, should we introduce a BROKEN tag? (I'm not kidding. :) )
Because in a development tree, many things are known broken
and with this tag we may reduce the same bug-reports on
this list over and over again.

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
Penguin on this machine:  Linux 2.4.21  - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FtEuoxoigfggmSgRAvvxAJ4oeM9wSBYh9zSMESK90bFR+JfLXgCfWiDU
BZdHfen1MsXcNv6OicXSr9w=
=wrz0
-----END PGP SIGNATURE-----

