Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129621AbQKCANm>; Thu, 2 Nov 2000 19:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130051AbQKCANd>; Thu, 2 Nov 2000 19:13:33 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:30980 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129621AbQKCANT>;
	Thu, 2 Nov 2000 19:13:19 -0500
Date: Thu, 2 Nov 2000 23:13:43 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0010291558550.15902-100000@fs1.dekanat.physik.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.21.0011022312560.14650-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Console colors are completely messed up (read: black, I even suspect
> the font to be corrupt somehow) if switching back to console mode
> from X (either by quitting or ctrl-alt-fX) in recent 2.4.0-textXX
> kernels. 2.2.XX do work just fine. Is this a known problem with a
> known fix?

How recent of a test kernel. Yes their was a problem with the console
palette but it is now fixed in the most recent test kernels.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
