Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268033AbRG2P0p>; Sun, 29 Jul 2001 11:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268045AbRG2P0e>; Sun, 29 Jul 2001 11:26:34 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:43525 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S268033AbRG2P02>;
	Sun, 29 Jul 2001 11:26:28 -0400
Date: Sun, 29 Jul 2001 17:26:30 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Debian-Devel List <debian-devel@lists.debian.org>
Cc: Jean Charles Delepine <delepine@u-picardie.fr>,
        Herbert Xu <herbert@debian.org>,
        Manoj Srivastava <srivasta@debian.org>
Subject: Re: make rpm
Message-ID: <20010729172630.A22503@wiggy.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org,
	Debian-Devel List <debian-devel@lists.debian.org>,
	Jean Charles Delepine <delepine@u-picardie.fr>,
	Herbert Xu <herbert@debian.org>,
	Manoj Srivastava <srivasta@debian.org>
In-Reply-To: <20010730004916.A2359@broken.wedontsleep.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010730004916.A2359@broken.wedontsleep.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Previously Steve Kowalik wrote:
> make-kpkg --revision=${KERNELRELEASE} kernel_image",surely?

No, the package revision is completely seperate from the kernel
release version.

Wichert.



-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
