Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUFYWTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUFYWTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUFYWTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:19:18 -0400
Received: from pop.gmx.de ([213.165.64.20]:30618 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266878AbUFYWTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:19:17 -0400
X-Authenticated: #4512188
Message-ID: <40DCA4E2.4040602@gmx.de>
Date: Sat, 26 Jun 2004 00:19:14 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040618)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck2 (was Re: 2.6.7-ck1)
References: <40DC2D28.5020605@kolivas.org> <40DC2DAF.2090204@kolivas.org> <40DCA2CA.6060102@gmx.de>
In-Reply-To: <40DCA2CA.6060102@gmx.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Hi,
> 
> like in the other thread, I also think there is something fishy about 
> staircase 7.4.

[snip]
> Revertung to staircase 7.3 (on ck1) it seems to be ok.

After some further tests I am not sure anymore about this. I did a 
recompile of xine-lib using staircase 7.3. At first everything seems to 
be normal, but nearly at the end of the compile, the system started to 
get into this blocking state:

I wnated to start a kedit and a konsole, but it took forever. Only afer 
the compile was done and the package actually gets emerge, both windows 
showed up. Hmmm, so I revert to staircase 7.1 and check it out...

Prakash
