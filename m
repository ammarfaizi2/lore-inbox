Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129254AbRBBMQt>; Fri, 2 Feb 2001 07:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbRBBMQj>; Fri, 2 Feb 2001 07:16:39 -0500
Received: from charybda.fi.muni.cz ([147.251.48.214]:38405 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S129254AbRBBMQ1>; Fri, 2 Feb 2001 07:16:27 -0500
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Fri, 2 Feb 2001 13:16:23 +0100
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010202131623.A6082@informatics.muni.cz>
In-Reply-To: <20010202122849.A4088@informatics.muni.cz> <3A7A944D.A2AB9FE@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A7A944D.A2AB9FE@namesys.com>; from reiser@namesys.com on Fri, Feb 02, 2001 at 02:04:45PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
: This is why our next patch will detect the use of gcc 2.96, and complain, in the
: reiserfs Makefile.
: 
	OK, thanks. It works with older compiler (altough I use gcc 2.96
for a long time for compiling various 2.[34] kernels without problem).

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
