Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRHMTdQ>; Mon, 13 Aug 2001 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266808AbRHMTdG>; Mon, 13 Aug 2001 15:33:06 -0400
Received: from ppp30.ts3.Gloucester.visi.net ([206.246.230.158]:752 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S266606AbRHMTcy>; Mon, 13 Aug 2001 15:32:54 -0400
Date: Mon, 13 Aug 2001 15:32:58 -0400
From: Ben Collins <bcollins@debian.org>
To: Mircea Ciocan <mirceac@interplus.ro>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something that can be done against this ???
Message-ID: <20010813153258.X30381@visi.net>
In-Reply-To: <E15WK98-0007gd-00@the-village.bc.nu> <3B7822E5.9AE35D4A@interplus.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B7822E5.9AE35D4A@interplus.ro>; from mirceac@interplus.ro on Mon, Aug 13, 2001 at 09:56:37PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2001 at 09:56:37PM +0300, Mircea Ciocan wrote:
> 	The attached piece of script kiddie shit is the first one that worked
> flawlessly on my Mandrake box :((( ( kernel 2.4.7ac2, glibc-2.2.3 ),
> instant root access !!!.
> 	I was stunned, and it seem that is the beginning of a Linux Code Red
> lookalike worm :(((( using that exploit, probably this is not the most
> apropriate place to send this, but I'm not subscribed to the glibc
> mailing list and I just hope that some glibc hackers are on linux kernel
> list also and they see that and do something before we join the ranks of
> M$.

Wow, someone tried to pass off this as an exploit? Looks very much like
Debian's fakeroot package, used to give a false root lookalike shell
(helps when building things as normal user, when they need to think they
are root).

Nice, but not an exploit. Just a cheap old trick.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
