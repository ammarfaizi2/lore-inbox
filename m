Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSFDUGe>; Tue, 4 Jun 2002 16:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSFDUGT>; Tue, 4 Jun 2002 16:06:19 -0400
Received: from www.transvirtual.com ([206.14.214.140]:1029 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316751AbSFDUFd>; Tue, 4 Jun 2002 16:05:33 -0400
Date: Tue, 4 Jun 2002 13:05:27 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mips@oss.sgi.com>, <linux-mips-kernel@lists.sourceforge.net>
Subject: [PATCH] fbdev updates.
Message-ID: <Pine.LNX.4.44.0206041248330.1200-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   This patch includes the latest in the fbdev BK repository. I have
modified several fbdev drivers (maxinefb, tx3912fb, pmag drivers) to the
new api. Please test these changes out before I submit them to linus.
Thank you. It is against the latest BK tree and 2.5.20.

diff:

   http://www.transvirtual.com/~jsimmons/fbdev.diff.gz

BK:

   http://fbdev.bkbits.net:8080/fbdev-2.5

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/



