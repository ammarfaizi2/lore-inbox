Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129544AbQKCAcf>; Thu, 2 Nov 2000 19:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQKCAc0>; Thu, 2 Nov 2000 19:32:26 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:46852 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129544AbQKCAbw>;
	Thu, 2 Nov 2000 19:31:52 -0500
Date: Thu, 2 Nov 2000 23:32:17 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Narancs 1 <narancs1@externet.hu>
Cc: Brett <bpemberton@dingoblue.net.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, kraxel@goldbach.in-berlin.de,
        linux-kernel@vger.kernel.org
Subject: Re: vesafb doesn't work in 240t10?
In-Reply-To: <Pine.LNX.4.02.10011021512560.5828-100000@prins.externet.hu>
Message-ID: <Pine.LNX.4.21.0011022330570.14650-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What fb driver would support it?

I seen a i810 fbdev driver before but I haven't see any updates to it in a
awhile.

> does vga16 support 1024x768?

No. vga16 supports standard vga graphics modes (ie 640x480 16 colors).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
