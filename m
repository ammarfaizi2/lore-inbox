Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313938AbSEATQx>; Wed, 1 May 2002 15:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313943AbSEATQw>; Wed, 1 May 2002 15:16:52 -0400
Received: from www.transvirtual.com ([206.14.214.140]:33033 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S313938AbSEATQw>; Wed, 1 May 2002 15:16:52 -0400
Date: Wed, 1 May 2002 12:16:31 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] fddev fixes due to massive change.
Message-ID: <Pine.LNX.4.10.10205011214240.1912-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to massive changes and few testers a few things where missed. THis
patches fixes all the problems that where reported to me. I have both a
classic diff and a BK url to work with. The patch is against 2.5.12

http://fbdev.bkbits.net/fbdev-2.5

http://www.transvirtual.com/~jsimmons/fbdev_fixs.diff

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

