Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132502AbRC1Gd6>; Wed, 28 Mar 2001 01:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132511AbRC1Gdt>; Wed, 28 Mar 2001 01:33:49 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:63241 "HELO sh0n.net") by vger.kernel.org with SMTP id <S132502AbRC1Gdb>; Wed, 28 Mar 2001 01:33:31 -0500
Date: Wed, 28 Mar 2001 01:33:08 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Disturbing news.. Idea
In-Reply-To: <Pine.LNX.4.30.0103280115180.7637-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.30.0103280132120.7704-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why not make a new file permission?

to deny a ELF binary the ability to modify the ELF entry point?

like +p if the file had +p (by default) the kernel would deny the ELF
binary the ability to modify files.

Shawn.

On Wed, 28 Mar 2001, Shawn Starr wrote:

>
> http://news.cnet.com/news/0-1003-200-5329436.html?tag=lh
>
> Isn't it time to change the ELF format to stop this crap?
>
> Shawn.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

