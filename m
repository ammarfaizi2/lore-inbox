Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSE3TjR>; Thu, 30 May 2002 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316848AbSE3TjQ>; Thu, 30 May 2002 15:39:16 -0400
Received: from www.transvirtual.com ([206.14.214.140]:57869 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316847AbSE3TjQ>; Thu, 30 May 2002 15:39:16 -0400
Date: Thu, 30 May 2002 12:38:52 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Hannu Mallat <hmallat@cc.hut.fi>, Denis Oliver Kropp <dok@convergence.de>,
        Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Fbdev updates and fixes.
Message-ID: <Pine.LNX.4.10.10205301227340.12679-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are several fixes and a few new ports. The drivers I ported over
to the new api are: 

1) 3DFX Voodoo3+ fbdev driver 

2) NeoMagic fbdev driver

Please review these drivers. 

-----------------
The fixes where for the anakin framebuffer and CLPS711X framebuffer.


/////////////////////////////////////////////////////////////////////
The standard diff is at 

http://www.transvirtual.com/~jsimmons/fbdev.diff

and the BK link is 

http://fbdev.bkbits.net:8080/fbdev-2.5

Thank you.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/


