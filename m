Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSLIGRo>; Mon, 9 Dec 2002 01:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSLIGRo>; Mon, 9 Dec 2002 01:17:44 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:45288 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262901AbSLIGRn>;
	Mon, 9 Dec 2002 01:17:43 -0500
Date: Mon, 9 Dec 2002 17:18:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, george@mvista.com, jim.houston@ccur.com,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-Id: <20021209171850.1c2a8c32.sfr@canb.auug.org.au>
In-Reply-To: <20021208.124100.71913406.davem@redhat.com>
References: <Pine.LNX.4.44.0212060944030.23118-100000@home.transmeta.com>
	<Pine.LNX.4.44.0212061111090.1489-100000@home.transmeta.com>
	<20021208.124100.71913406.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Dec 2002 12:41:00 -0800 (PST) "David S. Miller" <davem@redhat.com> wrote:
>
>    From: Linus Torvalds <torvalds@transmeta.com>
>    Date: Fri, 6 Dec 2002 11:20:26 -0800 (PST)
> 
>    I did the nanosleep() implementation using the new infrastructure now, and
>    am pushing it out as I write this.
>  ...   
>    Compat people can hopefully fix it up.
> 
> I'm fixing this up right now.

Thanks for this, Dave.

Isn't it nice that it only needs to be fixed once :-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
