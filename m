Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbUKRXdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbUKRXdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUKRXcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:32:24 -0500
Received: from main.gmane.org ([80.91.229.2]:41354 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262996AbUKRX3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:29:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <Fieroch@web.de>
Subject: Re: SNES gamepad doesn't work with kernel 2.6.x
Date: Fri, 19 Nov 2004 00:29:49 +0100
Message-ID: <419D306D.9000600@web.de>
References: <cn044e$nnk$1@sea.gmane.org>	 <8ecd274304111108404f3ecd2c@mail.gmail.com>	 <cn0pvt$mcv$1@sea.gmane.org>	 <8ecd27430411120227411e865f@mail.gmail.com> <4194FF96.4030106@web.de> <8ecd27430411121032756fbbd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-de, en-us, en
In-Reply-To: <8ecd27430411121032756fbbd2@mail.gmail.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Aristeu Sergio Rozanski Filho wrote:
| maybe I'm wrong but the format foo.bar= is only used when it's
| compiled as built-in, not as module
|
| then, try do:
|    modprobe gamecon map=0,1
|
| it should work

Yes thanks, it works! Now I can load the module gamecon but the gamepad
does not respond for example with jstest or jscalibrator.
So doesn't my parallel port supply the gameport with enough power?

Thanks,
Alexander
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBnTBtlLqZutoTiOMRAsQfAJ9QI5ZAZHQ0VvQrsNfCHbe1UjuXSACdFfHG
akhsG0A630nNovd0Al/TY/w=
=JjMp
-----END PGP SIGNATURE-----

