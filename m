Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292036AbSBYR7S>; Mon, 25 Feb 2002 12:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292908AbSBYR7I>; Mon, 25 Feb 2002 12:59:08 -0500
Received: from www.transvirtual.com ([206.14.214.140]:58888 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S292036AbSBYR65>; Mon, 25 Feb 2002 12:58:57 -0500
Date: Mon, 25 Feb 2002 09:58:41 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Carlos Manuel Duclos Vergara <carlos@embedded.cl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PATCH: FrameBuffer Monitor Functions
In-Reply-To: <20020225145015.46d7c9ad.carlos@embedded.cl>
Message-ID: <Pine.LNX.4.10.10202250957110.10454-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
> this patch is to avoid the cooking of monitors from inside the
> framebuffer subsystem. Normally this would be made by
> fbmon_valid_timings function, but actually this function does nothing.
> So i start writing a new implementation that will make some checks, note
> that is not the full answer because it requires to user use another data
> structures normally don't used, but for now it checks the basic stuff.
> bye

Patch is where? Also please send the patch to me, Geert and the fbdev
list. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

