Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131451AbQJ2ANG>; Sat, 28 Oct 2000 20:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131462AbQJ2AMz>; Sat, 28 Oct 2000 20:12:55 -0400
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:39872
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S131451AbQJ2AMe>; Sat, 28 Oct 2000 20:12:34 -0400
Date: Sun, 29 Oct 2000 02:12:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] ide-patch for 2.2.18(pre)
In-Reply-To: <Pine.LNX.4.21.0010280032200.9401-100000@tricky>
Message-ID: <Pine.NEB.4.30.0010290207120.19188-100000@gaia.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2000, Bartlomiej Zolnierkiewicz wrote:

>...
> I don't use 2.2.x kernels anymore so I don't do ide-patches for pre
> kernels. But there will be patches for stable 2.2.x. (Although it's
> a real pain - I hate doing backporting instead of new stuff).

I have modified your patch to apply cleanly against 2.2.18pre18. You can
find this patch at

  http://www.fs.tum.de/~bunk/ide.2.2.18pre18.adrian.patch.bz2


cu,
Adrian

-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
