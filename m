Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130451AbQKKOwK>; Sat, 11 Nov 2000 09:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQKKOwA>; Sat, 11 Nov 2000 09:52:00 -0500
Received: from Cantor.suse.de ([194.112.123.193]:61704 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130451AbQKKOvw>;
	Sat, 11 Nov 2000 09:51:52 -0500
Date: Sat, 11 Nov 2000 15:51:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: Keith Owens <kaos@ocs.com.au>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Where is it written?
Message-ID: <20001111155147.A6367@inspiron.suse.de>
In-Reply-To: <8ui698$c2q$1@cesium.transmeta.com> <11198.973906134@ocs3.ocs-net> <20001111001704.B2766@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001111001704.B2766@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Sat, Nov 11, 2000 at 12:17:04AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 12:17:04AM -0500, Michael Meissner wrote:
> Other than the minor little fact that -mregparm=n exposes several latent
> compiler bugs, that since it is not part of the ABI, it isn't on anybody's
> radar screen as needing to be fixed.  This is of course the downside of free

mregparm bug is supposed to been fixed in 2.95 by Bernd Schmit.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
