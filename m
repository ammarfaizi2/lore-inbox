Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267875AbRG3Ur1>; Mon, 30 Jul 2001 16:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbRG3UrR>; Mon, 30 Jul 2001 16:47:17 -0400
Received: from anime.net ([63.172.78.150]:16655 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S267875AbRG3UrG>;
	Mon, 30 Jul 2001 16:47:06 -0400
Date: Mon, 30 Jul 2001 13:46:49 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Kurt Garloff <garloff@suse.de>
cc: "James A. Treacy" <treacy@home.net>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Random (hard) lockups
In-Reply-To: <20010730222133.D26097@pckurt.casa-etp.nl>
Message-ID: <Pine.LNX.4.30.0107301344460.17564-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Kurt Garloff wrote:
> On Sun, Jul 29, 2001 at 02:34:01PM -0400, James A. Treacy wrote:
> > The machine is a 1GHz Athlon (266) on an MSI K7T Turbo with 256M ram,
> A 1.2GHz Athlon with the very same motherboard and the same amount of RAM
> seems to be stable with 2.4.7 and PPro or K6 optimizations and crashes
> during the init procedure if the kernel is optimized for K7.

Perhaps someone can make a test case .c program which uses K7
optimizations to smash memory? It would be nice to be able to pin this
down. Obviously, the standard memory testers aren't catching it.

Is this only happening on DDR systems?

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

