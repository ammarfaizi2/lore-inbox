Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVDOIXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVDOIXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 04:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVDOIVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 04:21:50 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:4616 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S261770AbVDOIVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 04:21:34 -0400
Message-ID: <425F7919.2010402@gentoo.org>
Date: Fri, 15 Apr 2005 09:19:37 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Kujau <evil@g-house.de>
CC: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA Oops (triggered by xmms)
References: <425EFB32.2010000@g-house.de> <Pine.LNX.4.62.0504150150240.3466@dragon.hyggekrogen.localhost> <425F07A6.2010402@g-house.de>
In-Reply-To: <425F07A6.2010402@g-house.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1DMM4u-000Gr5-M0*UcyehSlprQI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau wrote:
> oh, this sounds good. strange though, that my 2.6.11-gentoo-r5 (whatever
> they've patched in there) *never* oopsed the days ago but all of a sudden
> started to oops yesterday....

Probably because you changed alsa-lib versions. By the way, it is fixed in
gentoo-sources-2.6.11-r6.

Daniel
