Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283938AbRL1BNL>; Thu, 27 Dec 2001 20:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284017AbRL1BNB>; Thu, 27 Dec 2001 20:13:01 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:56783
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283938AbRL1BMk>; Thu, 27 Dec 2001 20:12:40 -0500
Date: Thu, 27 Dec 2001 19:57:38 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011227195738.A26889@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200112280024.fBS0OYH26337@snark.thyrsus.com> <Pine.LNX.4.33.0112280147290.18346-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112280147290.18346-100000@Appserv.suse.de>; from davej@suse.de on Fri, Dec 28, 2001 at 01:54:42AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
>                                     Maybe keep them both in the
> tree until this issue is worked out ? That way those who want to
> play with kbuild can do so, and those who build a few dozen
> kernels a day don't have to twiddle thumbs.

That is such an unutterably horrible concept that the very tentacles
of Cthulhu himself must twitch in dread at the thought.  The last thing
anyone sane wants to do is have to maintain two parallel build systems
at the same time.

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

You know why there's a Second Amendment?  In case the government fails to
follow the first one.
         -- Rush Limbaugh, in a moment of unaccustomed profundity 17 Aug 1993
