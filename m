Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279303AbRJ2Rjc>; Mon, 29 Oct 2001 12:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRJ2RjW>; Mon, 29 Oct 2001 12:39:22 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:40166 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S279303AbRJ2RjL>; Mon, 29 Oct 2001 12:39:11 -0500
Date: Mon, 29 Oct 2001 09:42:37 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Justin Mierta <Crazed_Cowboy@stones.com>
cc: <linux-kernel@vger.kernel.org>, <hahn@physics.mcmaster.ca>,
        <alan@lxorguk.ukuu.org.uk>, <lung@theuw.net>
Subject: Re: ECS k7s5a motherboard doesnt work
In-Reply-To: <3BDD0D0E.6000609@stones.com>
Message-ID: <Pine.LNX.4.33.0110290942190.27558-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sis900 is the integrated ethernet controller...

joelja

On Mon, 29 Oct 2001, Justin Mierta wrote:

> here's some more info for everyone trying to help:
> redhat says (at some point) that it insmod'd sis900, not the sis5513
> that mark had suggested, and the sis735 that everything says is actually
> in the motherboard.  (i have to assume the sis900 was ide, because it
> didnt tell me anything more useful than "insmod sis900" and that it worked)
>
> however, the messages i'm seeing are something like this:
> hda atapi: reset complete
> irq timeout: complete status = 0xC0   { busy }       (sometimes thats 0xD0)
>
> then there's a few lines every now and then saying "drive not ready for
> command" and "I/O error"
>
> any suggestions?
>
> justin
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


