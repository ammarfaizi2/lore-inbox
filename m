Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265932AbSKFS31>; Wed, 6 Nov 2002 13:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265946AbSKFS31>; Wed, 6 Nov 2002 13:29:27 -0500
Received: from pasky.ji.cz ([62.44.12.54]:20986 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S265932AbSKFS30>;
	Wed, 6 Nov 2002 13:29:26 -0500
Date: Wed, 6 Nov 2002 19:36:03 +0100
From: Petr Baudis <pasky@ucw.cz>
To: xmb <xmb@kick.sytes.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question about switching to a fresh kernel tree
Message-ID: <20021106183602.GC5219@pasky.ji.cz>
Mail-Followup-To: xmb <xmb@kick.sytes.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <2147483647.1036611045@[192.168.1.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2147483647.1036611045@[192.168.1.2]>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Nov 06, 2002 at 07:30:45PM CET, I got a letter,
where xmb <xmb@kick.sytes.net> told me, that...
> Yo,
> 
> to switch to a completly new and fresh kernel src tree, but using the old 
> configs... would it be enough to copy the old .config and Makefile to the 
> new tree

Copy the .config and then do make oldconfig in the new tree. README could be
interesting reading for you, BTW ;-).

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
