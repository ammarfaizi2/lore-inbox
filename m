Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286673AbRL1BkC>; Thu, 27 Dec 2001 20:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286672AbRL1Bjz>; Thu, 27 Dec 2001 20:39:55 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:59398 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286649AbRL1Bit>;
	Thu, 27 Dec 2001 20:38:49 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@suse.de>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 02:22:01 BST."
             <Pine.LNX.4.33.0112280219090.18346-100000@Appserv.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 12:38:37 +1100
Message-ID: <18645.1009503517@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 02:22:01 +0100 (CET), 
Dave Jones <davej@suse.de> wrote:
>On Thu, 27 Dec 2001, Eric S. Raymond wrote:
>
>> That is such an unutterably horrible concept that the very tentacles
>> of Cthulhu himself must twitch in dread at the thought.  The last thing
>> anyone sane wants to do is have to maintain two parallel build systems
>> at the same time.
>
>Funny, I could have sworn I read this was Keith's intention at least
>for a few pre's. Maybe I misinterpreted his intentions.

Only long enough to prove that kbuild 2.5 built kernels that worked.
And to give unconverted architectures a kernel that had both old and
new kbuild in it for their conversion.  Once kbuild 2.5 has proved it
works, kbuild 2.4 is coming out.

