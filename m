Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269639AbUJAAlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbUJAAlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269643AbUJAAlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:41:07 -0400
Received: from pop.gmx.net ([213.165.64.20]:63959 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269639AbUJAAlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:41:01 -0400
X-Authenticated: #135941
Message-ID: <415CA7A9.2070703@gmx.de>
Date: Fri, 01 Oct 2004 02:41:13 +0200
From: Arik Funke <arik.funke@gmx.de>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Via VT82C597: Possible to get USB to work reliably?
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Please CC any replys to be personally as the volume of this mailinglist
is unfortunately too much for my free account. Thanks.

Hello together,

during the last 1.5 weeks I have lost a lot of hair over following .

BACKGROUND: I have a FIC 2012 mainboard with uses the VIA VT82C597
chipset. Attached to the usb port is a usb memory pen drive which serves
as the root device.

PROBLEM: USB produces gets bulk transfer message timeouts for earlier
kernels ~2.4.6. Or inconsistent links (looses link after some time) for
newer kernels ~2.6.7 (messages similar to "refusing I/O to device being
removed" or "refusing I/O to dead device"). I have tried kernels until
2.6.9-rc2 (could not get to run at all).

After lots of research I realized that usb problems with via seem to be
a very common problem but could not find anything definitive.

Can anybody tell me whether this chipset works with any kernel - and if
yes with which? I guess I have to use a different mainboard!?

Thank you very much in advace!

Cheers,
Arik



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBXKep//PXyz2NiW8RAjeDAJ9WhgHaSGb7DzFB3PzlLXPvg0OemwCdHOEF
Z+lbtYIt49KOjEy1X58asaE=
=kL2X
-----END PGP SIGNATURE-----
