Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbQJaWwC>; Tue, 31 Oct 2000 17:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbQJaWvw>; Tue, 31 Oct 2000 17:51:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:40435 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129249AbQJaWve>; Tue, 31 Oct 2000 17:51:34 -0500
Date: Tue, 31 Oct 2000 20:48:50 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF49C8.475C2EA7@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010312047590.1190-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> Larry McVoy wrote:

> > Consider your
> > recent context switch claims.  Yes, I believe that you can do the moral
> > equiv of a longjmp() in the kernel in a few cycles, but that isn't a
> > context switch, at least, it isn't the same a context switch in the
> > operating system sense.  

> A context switch in anoperating system context in it's simplest for is
> 
> mov    x, esp
> mov    esp, y

> > processes with virtual memory?
> Yes.

Maybe you could tell us how long the context switch
between processes with virtual memory takes, that
would be a more meaningful comparison...

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
