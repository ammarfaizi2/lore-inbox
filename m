Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316726AbSERAid>; Fri, 17 May 2002 20:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316729AbSERAic>; Fri, 17 May 2002 20:38:32 -0400
Received: from waste.org ([209.173.204.2]:50088 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316726AbSERAib>;
	Fri, 17 May 2002 20:38:31 -0400
Date: Fri, 17 May 2002 19:38:29 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Wayne.Brown@altec.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
In-Reply-To: <86256BBC.0072F8A9.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.4.44.0205171931500.28917-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002 Wayne.Brown@altec.com wrote:

> That wouldn't help me, because I'll never trust *any* build system --
> even good ol' "make" itself -- to make the right determination of what
> to recompile after applying one of Linus's or Alan's patch sets.
> I *always* "make mrproper" and recompile *everything* after patching.

And the new kbuild will do that faster - what the problem again? For those
of us who actually trust the makefile concept, if not the current
makefiles, the new kbuild also happens to be designed to do the right
thing after a patch.

More importantly, it makes the make system manageable again.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

