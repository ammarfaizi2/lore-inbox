Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbRB0KJ3>; Tue, 27 Feb 2001 05:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRB0KJT>; Tue, 27 Feb 2001 05:09:19 -0500
Received: from www.wen-online.de ([212.223.88.39]:23813 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129636AbRB0KJM>;
	Tue, 27 Feb 2001 05:09:12 -0500
Date: Tue, 27 Feb 2001 11:08:26 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: <shawn@rhua.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Causes more then
 just  msgs
In-Reply-To: <3A9B0EBE.BBC54F1@sh0n.net>
Message-ID: <Pine.LNX.4.33.0102271104320.927-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Shawn Starr wrote:

> It may not be an important message but what does happen is /dev/dsp becomes
> hung and no sound works after the fault. So something is definately wrong.

Do you mean it hangs without the BUG() inserted, or only after the oops?

	-Mike

