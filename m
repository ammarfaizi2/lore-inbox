Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287786AbSASWuw>; Sat, 19 Jan 2002 17:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287784AbSASWup>; Sat, 19 Jan 2002 17:50:45 -0500
Received: from www.transvirtual.com ([206.14.214.140]:6413 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287786AbSASWu0>; Sat, 19 Jan 2002 17:50:26 -0500
Date: Sat, 19 Jan 2002 14:50:09 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Sven <luther@dpt-info.u-strasbg.fr>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
In-Reply-To: <20020119182107.A32417@dpt-info.u-strasbg.fr>
Message-ID: <Pine.LNX.4.10.10201191443271.22692-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Mmm, ...
> 
> So what is the best place to look at if one wants to do some driver work. Not
> that i really have that much time, but i may look into porting the pm3fb
> driver to the new scheme, but ruby + 2.5.1 hangs hopelessly for me, and if it
> is not the latest stuff around, it would not be the best place to work from.

The best tree to work with is the Dave Jones tree for 2.5.X. DJ tree
provides a better testing ground. Eventually when stuff goes from DJ to
Linus tree ruby and 2.5.X will look alot more alike :-) 
 
> Also, i suppose there is no documentation whatsoever yet, apart from the
> source and the mailing list archive here ?

That is my fault :-( I have been so busy coding I haven't written any
docs. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/


