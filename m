Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268972AbRHLHb6>; Sun, 12 Aug 2001 03:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268974AbRHLHbt>; Sun, 12 Aug 2001 03:31:49 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:56301
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S268972AbRHLHbg>; Sun, 12 Aug 2001 03:31:36 -0400
Date: Sun, 12 Aug 2001 09:31:40 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Keith Owens <kaos@ocs.com.au>
Cc: Tom Rini <trini@kernel.crashing.org>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, Release 1.1 is available.
Message-ID: <20010812093140.A820@jaquet.dk>
In-Reply-To: <20010811212051.A819@jaquet.dk> <6820.997582287@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6820.997582287@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Aug 12, 2001 at 12:11:27PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 12:11:27PM +1000, Keith Owens wrote:
[...] 
> >pp_makefile2: Cannot find source for target drivers/sound/emu10k1/efxmgr.o
> >pp_makefile2: Cannot find source for target drivers/sound/emu10k1/joystick.o
> >pp_makefile2: Cannot find source for target drivers/sound/emu10k1/passthrough.o
> 
> You put kbuild-2.5-2.4.8-1 on an 2.4.8-pre kernel.  Linus moved emu10k1
> to its own directory in 2.4.8.  You have match kbuild with the correct
> kernel.

Yes, I have to and no, I did not. It was kbuild-2.5-2.4.8-1 on a
freshly untarred 248.tar.gz from a mirror. But kbuild-...-2 fixes
it for me fine.

-- 
        Rasmus(rasmus@jaquet.dk)

"Give a man a fish, and he eats for a day. Teach a man to fish, and a
US Navy submarine will make sure he's never hungry again." -- Chris
Neufeld
