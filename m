Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbQLRGVb>; Mon, 18 Dec 2000 01:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbQLRGVM>; Mon, 18 Dec 2000 01:21:12 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:22144 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S129610AbQLRGVH>;
	Mon, 18 Dec 2000 01:21:07 -0500
Message-ID: <3A3DA5B0.6BACE66E@pobox.com>
Date: Sun, 17 Dec 2000 21:50:40 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting Group
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10-ll i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3 woes
In-Reply-To: <Pine.LNX.4.10.10012171353270.2052-100000@penguin.transmeta.com> <3A3D4FB4.CBA887E4@bellsouth.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Similar problem here - with CONFIG_DRM_TDFX=m
I have not gotten a tdfx.o module complied since the
start of the test13-pre series...

So no quake 3 arena unless I want to play at < 1 fps...

:(

jjs

Albert Cranford wrote:

> With CONFIG_DRM_R128=m
> we fail to produce module linux/drivers/char/drm/r128.o

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
