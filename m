Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269680AbUJADfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269680AbUJADfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 23:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269681AbUJADfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 23:35:31 -0400
Received: from nabe.tequila.jp ([211.14.136.221]:50371 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S269679AbUJADfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 23:35:08 -0400
Message-ID: <415CD05F.4040305@tequila.co.jp>
Date: Fri, 01 Oct 2004 12:34:55 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040917 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "Markus T." <markus@trippelsdorf.net>
Subject: Re: Linux 2.6.9-rc3
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <415C80C1.8070406@pobox.com> <415CA7DB.7080203@tequila.co.jp> <200409302330.26396.gene.heskett@verizon.net>
In-Reply-To: <200409302330.26396.gene.heskett@verizon.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/01/2004 12:30 PM, Gene Heskett wrote:

|> Beats me, Clemens.  But at the time, I got curious and the problem was
|> 100% repeatable using the bz2 src code files I had.  The third time I
|> went after the srcs and patches to build that kernel, I got the .gz
|> versions of both, and they worked first time.  Then I went back to
|> the .bz2's and was seeing the same problem as the first 2 downloads
|> gave me.  I mv'd that src file & patch, went after the .bz2's again
|> (for the 3rd time), and that time it worked flawlessly.  Both the 2nd
|> and 3rd dl's files had the exact same md5sum too.  Go figure.

have you unpacked the source and made a diff? is the source the same
then? perhaps its something with CPU/RAM ? Ever thought of that. If only
you have it, then what kind of libraries are you using, perhaps it some
problem only on your box. Can you repeat that on other boxes, etc.

|> bz2 problem?  DamnedifIknow.  snilmerg maybe?  But it goes away if I
|> stick to the .gz's.

It would be interesting to investigate this further. Because if bz2 is
not save to transport data, then you can't use it anymore.

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBXNBfjBz/yQjBxz8RAkLBAKCTFd4niu/StV85xloSuHmOowcOUgCdGTyI
18/zlWp2oyfNz/jSJ7Zpjig=
=iG6j
-----END PGP SIGNATURE-----
