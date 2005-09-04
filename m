Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVIDRFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVIDRFg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbVIDRFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:05:36 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:50677 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750970AbVIDRFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:05:35 -0400
Message-ID: <431B2ACE.8030806@stesmi.com>
Date: Sun, 04 Sep 2005 19:11:42 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Davis <alex14641@yahoo.com>
CC: linux-kernel@vger.kernel.org, vda@ilport.com.ua
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
In-Reply-To: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alex Davis wrote:
>>Please don't tell me to "care for closed-source drivers". 
> 
> ndiswrapper is NOT closed source. And I'm not asking you to "care".

While ndiswrapper might not be closed source, I would not call the
windows driver it loads open source ...

There is really no difference between madwifi+closed source hal
to ndiswrapper+windows driver.

Both are just as (non-)debuggable.

Ok, madwifi exposes more of it's driver source to us, but still.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDGyrOBrn2kJu9P78RAvIxAJ426eTZbTtB5v92A+ipxsKEFW4sPACgnYna
iXGFMduZgJ92UriSHvwTW3g=
=YcU6
-----END PGP SIGNATURE-----
