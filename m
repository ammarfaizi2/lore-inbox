Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUDSOWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbUDSOWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:22:55 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:3414 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S264450AbUDSOWM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 10:22:12 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Gilles May <gilles@canalmusic.com>, linux-kernel@vger.kernel.org
Subject: Re: PDC20376 PATA?
Date: Mon, 19 Apr 2004 14:20:16 +0000
User-Agent: KMail/1.5.3
References: <407FED4A.8040307@canalmusic.com>
In-Reply-To: <407FED4A.8040307@canalmusic.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200404191420.17116.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hello everybody::
>
> I have got a problem getting my onboard FastTrak 376 Controller to work.
> The motherboard is an Asus A7V8X.

I have the same controller, but welded into an MSI KT4 Ultra.

With Mandrake 9.2 it gets detected and I was able to use the pata port with a 
20Gig Maxtor drive.

The module Mandrake uses for this is the pdc-ultra module, although I'm not 
sure if its in the kernel or a 3rd party addition by Mandrake.

Mark.


- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAg+AhBn4EFUVUIO0RAoZ8AKDI8+KCd5vLLiQv4YX5AIs1J9lnHACbBsFU
RFUNQkplMvfBw8WjXPITqsU=
=cgaq
-----END PGP SIGNATURE-----

