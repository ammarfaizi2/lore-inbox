Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbQJaWyw>; Tue, 31 Oct 2000 17:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQJaWym>; Tue, 31 Oct 2000 17:54:42 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:26891 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129135AbQJaWya>; Tue, 31 Oct 2000 17:54:30 -0500
Message-ID: <39FF4CA5.8F3C2F31@timpanogas.org>
Date: Tue, 31 Oct 2000 15:50:13 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010312047590.1190-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:
> 
> On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> > Larry McVoy wrote:
> 
> > > Consider your
> > > recent context switch claims.  Yes, I believe that you can do the moral
> > > equiv of a longjmp() in the kernel in a few cycles, but that isn't a
> > > context switch, at least, it isn't the same a context switch in the
> > > operating system sense.
> 
> > A context switch in anoperating system context in it's simplest for is
> >
> > mov    x, esp
> > mov    esp, y
> 
> > > processes with virtual memory?
> > Yes.
> 
> Maybe you could tell us how long the context switch
> between processes with virtual memory takes, that
> would be a more meaningful comparison...
> 

Rik,

I'll bring down a NetWare 5 server, and snapshot the context switch code
from the NetWare debugger and email to you.

Jeff

> regards,
> 
> Rik
> --
> "What you're running that piece of shit Gnome?!?!"
>        -- Miguel de Icaza, UKUUG 2000
> 
> http://www.conectiva.com/               http://www.surriel.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
