Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287563AbSA1XVX>; Mon, 28 Jan 2002 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287616AbSA1XVN>; Mon, 28 Jan 2002 18:21:13 -0500
Received: from www.transvirtual.com ([206.14.214.140]:24837 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287563AbSA1XVC>; Mon, 28 Jan 2002 18:21:02 -0500
Date: Mon, 28 Jan 2002 15:20:41 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev accel wrapper.
Message-ID: <Pine.LNX.4.10.10201281516290.14010-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!
 
  This patch provides a wrapper to use a graphics card's accel engine.
This is a needed step to remove the mess with fbcon-cfb* etc. No driver
has been changed. Just the wrapper has been provided. Geert with your
blessing I like to see it applied to the DJ tree.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

