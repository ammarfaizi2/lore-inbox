Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSE3FLZ>; Thu, 30 May 2002 01:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316324AbSE3FLY>; Thu, 30 May 2002 01:11:24 -0400
Received: from www.transvirtual.com ([206.14.214.140]:35590 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316322AbSE3FLX>; Thu, 30 May 2002 01:11:23 -0400
Date: Wed, 29 May 2002 22:10:36 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Framebuffer policy [ was Re: Linux 2.5.19]
In-Reply-To: <20020530003133.H30585@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10205292154360.12660-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is about people who think they're god nicking patches from
> the author and maintainer of drivers and bypassing the maintainer
> completely.

Please no fighting. It is clear the problem is the lack of order here.
I understand how Russell feels. Most of the time people send in new fbdev
drivers or good size patches without consulting me or Geert first. I have
to say it has gotten better. So here goes for policy time:

--------------------------------------------------------------------
             Framebuffer driver policy.

1) Basic one or few line fixes for drivers can go straight into the
   kernel. Please don't abuse this.

2) All new drivers must be posted to the fbdev developement list for
   peer review. Me and/or geert have final fword about them going in.
   Please note we do get busy so just harass me about your driver. I
   will not be offended and it pushs me to go do it. I'm the type of
   person if I don't do it right away I will forget.

   linux-fbdev-devel@lists.sourceforge.net

3) Large changes should be posted to both the framebuffer list and the
   kernel mailing list as well to the framebuffer author if they
   are know. Again it is for peer review and wide scale testing. We 
   need to make clear what drivers where effect. And yes if you are the 
   maintainer of a driver you should mail yourself. It makes it easier
   for users to reply to you directly.  

If no one follows these rules then their changes will be ignored. No
exceptions including for myself.

-----------------------------------------------------------------
How does this sound? Again sorry about the confusion.



