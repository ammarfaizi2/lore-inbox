Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbRG3Vch>; Mon, 30 Jul 2001 17:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268086AbRG3Vc1>; Mon, 30 Jul 2001 17:32:27 -0400
Received: from anime.net ([63.172.78.150]:14608 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S267988AbRG3VcW>;
	Mon, 30 Jul 2001 17:32:22 -0400
Date: Mon, 30 Jul 2001 14:31:49 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: "Manuel A. McLure" <mmt@unify.com>
cc: Kurt Garloff <garloff@suse.de>, "James A. Treacy" <treacy@home.net>,
        <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Random (hard) lockups
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C3ED@pcmailsrv1.sac.unify.com>
Message-ID: <Pine.LNX.4.30.0107301424580.21409-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Manuel A. McLure wrote:
> I am seeing something very similar on my K7T Turbo/Athlon 900/256M PC133
> SDRAM (note to Dan, the K7T Turbo is an SDRAM mobo, not DDR)

Hmm. I have an MSI pro2-A which works fine with K7 optimizations...
tbird900, 256mb sdram...

May very well be a hardware design flaw. The pro2-a appears very carefully
engineered to keep most traces short and they went through a lot of effort
to keep traces the same length.

The only stability problems I've had were overloading the 300W PS with a
geforce2, all 6 PCI slots filled, 3 HD, 1 CDRW, and one DVDrom. Removing
one of the drives (CDRW or DVDrom) lowers the power consumption back into
the realm of 100% stability.

Next on my shopping list is a 450W PS :-)

Has anyone tried swapping buffered/unbuffered DIMMs to see if it made a
difference?

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

