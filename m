Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUB0Ld3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUB0Ld3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:33:29 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:6569 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261232AbUB0Ld1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:33:27 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
Date: Fri, 27 Feb 2004 12:27:32 +0100
User-Agent: KMail/1.6
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Mark Gross <mgross@linux.co.intel.com>, Tim Bird <tim.bird@am.sony.com>,
       root@chaos.analogic.com
References: <403E4363.2070908@am.sony.com> <200402261421.34885.mgross@linux.intel.com> <20040227071445.GA5695@devserv.devel.redhat.com>
In-Reply-To: <20040227071445.GA5695@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402271227.34354.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 27 February 2004 08:14, Arjan van de Ven wrote:
> The point I tried to make was that it would INCREASE latency. Unless you
> have misdesigned device drivers, which is something that is fixable :)
 
Not if you bought them as IP from some company. Or you did some
outsourcing and external development games.

Then you are basically lost and must workaround your problems instead of
fixing them.

Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPymkU56oYWuOrkARAsWUAKCTI3ikuVsV2xfFWS/frDBYCOJetACggQfr
NQcCvIS5I8jH4zWCPL5obYA=
=CoLz
-----END PGP SIGNATURE-----
