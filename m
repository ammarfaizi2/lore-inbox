Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281670AbRKZNcr>; Mon, 26 Nov 2001 08:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281671AbRKZNch>; Mon, 26 Nov 2001 08:32:37 -0500
Received: from ns.caldera.de ([212.34.180.1]:23996 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281670AbRKZNcc>;
	Mon, 26 Nov 2001 08:32:32 -0500
Date: Mon, 26 Nov 2001 14:32:26 +0100
Message-Id: <200111261332.fAQDWQF17920@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: olh@suse.de (Olaf Hering)
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/802/Makefile
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011126142425.B27554@suse.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011126142425.B27554@suse.de> you wrote:
> On Mon, Nov 26, Olaf Hering wrote:
>> 
>> the build stops when cl2llc.c has no write permissions.
>
> Here is a better version, suggested by Rik:

What about just removing cl2llc.c from the tarball?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
