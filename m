Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSEaAYz>; Thu, 30 May 2002 20:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSEaAYy>; Thu, 30 May 2002 20:24:54 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:50824 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S312938AbSEaAYx>;
	Thu, 30 May 2002 20:24:53 -0400
Date: Fri, 31 May 2002 10:24:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing bit from signal patches
Message-Id: <20020531102437.2ef91251.sfr@canb.auug.org.au>
In-Reply-To: <3CF68446.644850F8@linux-m68k.org>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Thu, 30 May 2002 21:57:58 +0200 Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Hi,
> 
> Stephen Rothwell wrote:
> 
> > Try this ...
> 
> This almost works. :)

Just goes to show I should go to bed earlier :-)

I assume it works if you put the function definition in the right place?

I will redo the patch (looking harder this time now that I am awake)
and submit it to Linus.


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
