Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRBBQhO>; Fri, 2 Feb 2001 11:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbRBBQhE>; Fri, 2 Feb 2001 11:37:04 -0500
Received: from charybda.fi.muni.cz ([147.251.48.214]:58118 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S129383AbRBBQgu>; Fri, 2 Feb 2001 11:36:50 -0500
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Fri, 2 Feb 2001 17:36:44 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010202173644.A12520@informatics.muni.cz>
In-Reply-To: <20010202131623.A6082@informatics.muni.cz> <E14OfPx-0006Pq-00@the-village.bc.nu> <20010202140900.B6082@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010202140900.B6082@informatics.muni.cz>; from kas@informatics.muni.cz on Fri, Feb 02, 2001 at 02:09:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: : 
: : 2.96-69 should be ok (thats the one I've been using without trouble). The 
: : original one with RH 7.0 off the CD does miscompile a few kernel things.
: 
: 	It is the original one. I'll try with the -69:
: 
	With 2.96-69 the reiserfs seems to work well.
Sorry for the confusion, I forgot to upgrade the gcc on my machine.

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
> Is there anything else I can contribute? -- The latitude and longtitude of
the bios writers current position, and a ballistic missile.       (Alan Cox)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
