Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUIOI5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUIOI5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUIOI5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:57:51 -0400
Received: from pop.gmx.de ([213.165.64.20]:13501 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263893AbUIOI5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:57:33 -0400
X-Authenticated: #4512188
Message-ID: <41480401.8030903@gmx.de>
Date: Wed, 15 Sep 2004 10:57:37 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Losing too many ticks! .... on a VIA epia board
References: <4146A09A.9010207@zensonic.dk> <41476812.7000401@zensonic.dk>
In-Reply-To: <41476812.7000401@zensonic.dk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thomas S. Iversen wrote:
| Thomas S. Iversen wrote:
|
|> Any clues to what is wrong and how I go about fixing it?!
|
|
| Well, I made a kernel without acpi support and the problem went away.
| Any clues to why that solved the problem?

Frequency scaling or anything alike? Have you tried using acpi pm timer?
This should prevent you from losing ticks.

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBSAQAxU2n/+9+t5gRAlw9AJ0ZXpDxhh+fhhmBrCIrplLFwNriSACgskqi
1xrE4nBXzzMoAjupSPecH48=
=ia4X
-----END PGP SIGNATURE-----
