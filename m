Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316241AbSEVQyP>; Wed, 22 May 2002 12:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316245AbSEVQyO>; Wed, 22 May 2002 12:54:14 -0400
Received: from www.transvirtual.com ([206.14.214.140]:21513 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316241AbSEVQyM>; Wed, 22 May 2002 12:54:12 -0400
Date: Wed, 22 May 2002 09:54:04 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] fbdev updates.
Message-ID: <Pine.LNX.4.10.10205220936580.4611-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   I just ported over a few driver to the new api. I also included a few
bug fixes as well as a few new drivers. Please try it out and send me any
patches. Once the testing is done I will ask Linus to included into his
tree. If you look at skeletonfb.c you will see actual info on the new api
to help you port it over to the new api.

BK:

   http://fbdev.bkbits.net:8080/fbdev-2.5

Diff:

   http://www.transvirtual.com/~jsimmons/fbdev.diff

P.S
   Yes with with new api I haven't finished the drawing penguin code so
you don't see a penguin yet. I will but I figured the new api is more
important.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

