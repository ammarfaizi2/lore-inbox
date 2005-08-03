Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVHCWwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVHCWwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVHCWww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 18:52:52 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:42115 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261428AbVHCWww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 18:52:52 -0400
Message-ID: <42F14A9B.2050803@gmail.com>
Date: Thu, 04 Aug 2005 00:52:11 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, Jiri Slaby <lnx4us@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.13-rc4-mm1] Re: Obsolete files in 2.6 tree
References: <42DED9F3.4040300@gmail.com> <42DF6F34.4080804@gmail.com>	 <20050726120727.GA2134@ucw.cz> <1122421245.2542.35.camel@localhost.localdomain>
In-Reply-To: <1122421245.2542.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox napsal(a):

>>>drivers/char/drm/gamma_dma.c
>>>drivers/char/drm/gamma_drv.c
>>>      
>>>
>
>Gamma is defunct certainly
>  
>
Removes gamma sources, headers and pointers from Kconfig and Makefile.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

patch is here (about 70 KiB):
http://www.fi.muni.cz/~xslaby/lnx/gamma.txt

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

