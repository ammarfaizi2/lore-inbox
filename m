Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbQLTXqF>; Wed, 20 Dec 2000 18:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbQLTXpp>; Wed, 20 Dec 2000 18:45:45 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:20947
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S130348AbQLTXpg>; Wed, 20 Dec 2000 18:45:36 -0500
Date: Thu, 21 Dec 2000 00:15:13 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@pluto.fachschaften.tu-muenchen.de>
To: John Reiser <jreiser@BitWagon.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: tighter compression for x86 kernels
In-Reply-To: <3A412C8D.59DDD9F2@BitWagon.com>
Message-ID: <Pine.NEB.4.31.0012202338040.21463-100000@pluto.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, John Reiser wrote:

> Beta release v1.11 of the UPX executable compressor http://upx.tsx.org
> offers new, tighter re-compression of compressed Linux kernels for x86.
> Additional space savings of about 15% have been seen using
> "upx --best vmlinuz" (example: 617431 ==> 525099, saving 92332 bytes).
> Both source (GPLv2) and pre-compiled binary for x86 are available.
               ^^^^^
That's not true. Read
  http://wildsau.idv.uni-linz.ac.at/mfx/upx-license.html


> [I'm not subscribed to this mailing list, so CC: or mail me if appropriate.]

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
