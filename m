Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268923AbRHLC1f>; Sat, 11 Aug 2001 22:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268924AbRHLC1Z>; Sat, 11 Aug 2001 22:27:25 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:16014
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268923AbRHLC1S>; Sat, 11 Aug 2001 22:27:18 -0400
Date: Sat, 11 Aug 2001 19:27:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Rasmus Andersen <rasmus@jaquet.dk>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available.
Message-ID: <20010811192711.D17435@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010811212051.A819@jaquet.dk> <6820.997582287@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6820.997582287@ocs3.ocs-net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 12:11:27PM +1000, Keith Owens wrote:
> On Sat, 11 Aug 2001 21:20:52 +0200, 
> Rasmus Andersen <rasmus@jaquet.dk> wrote:
> >pp_makefile2: drivers/char/defkeymap.o is selected but is not part of vmlinux, missing link_subdirs?
> 
> Against 2.4.8 + kbuild-2.5-2.4.8-1.  I will put up a -2 later today
> containing this fix and a few others.

k, thanks.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
