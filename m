Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292860AbSB1QZn>; Thu, 28 Feb 2002 11:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSB1QXD>; Thu, 28 Feb 2002 11:23:03 -0500
Received: from www.transvirtual.com ([206.14.214.140]:30983 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S293468AbSB1QWj>; Thu, 28 Feb 2002 11:22:39 -0500
Date: Thu, 28 Feb 2002 08:22:30 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tdfx ported to new fbdev api
Message-ID: <Pine.LNX.4.10.10202280820170.9321-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As you can see I have ported the 3dfx fbdev driver to the new api. It has
been tested on my home system and it works. I like others to try it out.
The patch is against 2.5.5-dj2


http://www.transvirtual.com/~jsimmons/tdfx.diff

Thank you.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

