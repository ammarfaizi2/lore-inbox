Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269384AbUI3SPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269384AbUI3SPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbUI3SPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:15:34 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:4279 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269384AbUI3SPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:15:25 -0400
Message-ID: <415C4D79.6060608@t-online.de>
Date: Thu, 30 Sep 2004 20:16:25 +0200
From: franz_pletz@t-online.de (Franz Pletz)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040917 Thunderbird/0.8 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Michal Rokos <michal@rokos.info>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
References: <200409230958.31758.michal@rokos.info> <200409231618.56861.michal@rokos.info> <415C37D8.20203@t-online.de> <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: r1DUIUZEgeVaVUzWdcvebQ6Bj94h8iwSoCDSY9d9nIAPM+c9DKaWY9
X-TOI-MSGID: 4a194644-b984-4ada-a7eb-4f3ac413ec76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It's definitely not in _my_ -rc3. Which kernel are you looking at?

Hmm, I just unpacked fresh sources from kernel.org, patched them up to 
rc3 and everything is now working fine. Seems like my kernel sources 
were in some way damaged from patching too much although I didn't 
experience any rejects.

Sorry for the noise.

Well, I guess next time I should really make sure that everything's sane 
before reporting something.

> This patch should clean up natsemi.c a bit, and makes the warnings go 
> away. Does it work for you? (It really should, it's just a basic 
> search-and-replace fix).

Yes, this one works well without any problems or warnings. Thanks.

Franz
