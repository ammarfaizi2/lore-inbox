Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285407AbRLGEcC>; Thu, 6 Dec 2001 23:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285408AbRLGEbw>; Thu, 6 Dec 2001 23:31:52 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:57776
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S285407AbRLGEbl>; Thu, 6 Dec 2001 23:31:41 -0500
Date: Thu, 6 Dec 2001 21:30:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] (no subject)
Message-ID: <20011207043059.GI30935@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <24493.1007698673@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24493.1007698673@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 03:17:53PM +1100, Keith Owens wrote:
> Linus, the time has come to convert the 2.5 kernel to kbuild 2.5.  I
> want to do this in separate steps to make it easier for architectures
> that have not been converted yet.
> 
> 2.5.1           Semi-stable kernel, after bio is working.
> 
> 2.5.2-pre1      Add the kbuild 2.5 and CML2 code, still using
>                 Makefile-2.5, supporting both CML1 and CML2.
>                 i386, sparc, sparc64 can use either kbuild 2.4 or 2.5,
>                 2.5 is recommended.
>                 ia64 can only use kbuild 2.5.
>                 Other architectures continue to use kbuild 2.4.
>                 Wait 24 hours for any major problems then -

Could we wait longer here?  Maybe 48 or 72 to give other arches time to
convert and attempt to sync again?  Or at least show it to Keith so he
can try and sync it up. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
