Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272360AbTHECCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 22:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272361AbTHECCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 22:02:52 -0400
Received: from smtp2.cwidc.net ([154.33.63.112]:37330 "EHLO smtp2.cwidc.net")
	by vger.kernel.org with ESMTP id S272360AbTHECCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 22:02:51 -0400
Message-ID: <3F2F103E.30800@tequila.co.jp>
Date: Tue, 05 Aug 2003 11:02:38 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Rahul Karnik <rahul@genebrew.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 from csv fails to compile
References: <200308041313.52755.schwaigl@eunet.at> <20030804064358.GA854@suse.de> <3F2EF677.1040308@tequila.co.jp> <3F2EFE78.9000906@genebrew.com>
In-Reply-To: <3F2EFE78.9000906@genebrew.com>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rahul Karnik wrote:

> Clemens Schwaighofer wrote:
>
>> I did, clean checkout (new directory), same error like before ...
>
>
> Can you diff against a current BK snapshot? This may be a problem with
> the BK->CVS gateway.

I would do immediatly if I would know how. I have installed bitkeeper
and I tried to do: bk pull bk://linux.bkbits.net/linux-2.5 but it just
gives me an error. I searched a bit, but I couldn't finde some helpful
help for how to checkout the tree from bk and at the moment I don't have
enough time to do so ...

would be a good thing to explain this in more detail on kernel.org eg
... perhaps directly on the main page ...

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/LxA9jBz/yQjBxz8RAt7HAKCVsoQey+dGURYUYxuPTET2mq9DmQCfQWFG
qftqIdFIP9pRCAuxCTnAU48=
=k+02
-----END PGP SIGNATURE-----

