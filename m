Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLRVOn>; Mon, 18 Dec 2000 16:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130805AbQLRVOd>; Mon, 18 Dec 2000 16:14:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20760 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130017AbQLRVO2>; Mon, 18 Dec 2000 16:14:28 -0500
Date: Mon, 18 Dec 2000 21:42:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001218214252.B23365@athlon.random>
In-Reply-To: <Pine.LNX.3.96.1001216000116.27376A-100000@artax.karlin.mff.cuni.cz> <Pine.LNX.4.21.0012181825180.2595-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0012181825180.2595-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Dec 18, 2000 at 06:29:24PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 06:29:24PM -0200, Rik van Riel wrote:
> Wrong. Getblk won't deadlock, it will just sleep and another

getblk will deadlock.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
