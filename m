Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129413AbQK0S73>; Mon, 27 Nov 2000 13:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129501AbQK0S7T>; Mon, 27 Nov 2000 13:59:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36100 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129413AbQK0S7H>; Mon, 27 Nov 2000 13:59:07 -0500
Message-ID: <3A22A7D8.13BEF4B6@transmeta.com>
Date: Mon, 27 Nov 2000 10:28:40 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Mandrake Install <install@linux-mandrake.com>
Subject: Re: Universal debug macros.
In-Reply-To: <200011270045.BAA13121@cave.bitwizard.nl>
                <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
                <8vsno2$pc6$1@cesium.transmeta.com>
                <m3vgt9nykk.fsf@matrix.mandrakesoft.com>
                <3A229E41.B3C278E2@transmeta.com>
                <m3aealnvt6.fsf@matrix.mandrakesoft.com>
                <3A22A0C9.6888B08@transmeta.com> <m366l9nv50.fsf@matrix.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chmouel Boudjnah wrote:
> 
> "H. Peter Anvin" <hpa@transmeta.com> writes:
> 
> > It's not that slow compared to a whole distro install, although you would
> > of course want to do it *optionally*.
> 
> that would be for sure, but keep in mind by experiences most people
> sent us a /lot/ of bug reports because they don't know how to do even
> if we wrote (IT IS ONLY FOR EXPERIENCED PEOPLE). Let say a scenario :
> 
> dumb^Hjoe user make a expert install even if he don't have any clue
> about what is a kernel or a compiler or even drivers (yep we have some
> users like this)
> joe user choose to compile kernel
> click on everything (sound fun all this checkboxes)
> choose to reboot on his kernel (this sound too cook he can make some
> uname -r on IRC to show ''his'' kernel)
> reboot and sure he put some idiotic options like IDE in modules.
> 
> as i said it's a very special case but we have so much strangness in
> our buisness...
> 
> You may say  that don't let the user choose the wrong option (ie:
> don't let to choose to put IDE as modules when he has installed on an
> only IDE partition), but there is too much case to handle...
> 
> > You wouldn't want to get into every single option, of course, but I
> 
> what do you purpose of something else of every single of options ?
> 

I'm talking about crap like the global compile options (processor, SMP,
etc.)

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
