Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131679AbRCTAwr>; Mon, 19 Mar 2001 19:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131693AbRCTAwj>; Mon, 19 Mar 2001 19:52:39 -0500
Received: from viper.haque.net ([64.0.249.226]:26273 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S131679AbRCTAwb>;
	Mon, 19 Mar 2001 19:52:31 -0500
Message-ID: <3AB6A997.6E4D8738@haque.net>
Date: Mon, 19 Mar 2001 19:51:35 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph Cheek <joseph@cheek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: KMALLOC_MAXSIZE undeclared in drivers/media/video/buz.c
In-Reply-To: <3AB698DD.5DAFDBA8@cheek.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grab my KMALLOC_MAXSIZE patch from this posting

http://marc.theaimsgroup.com/?l=linux-kernel&m=98398907520444&w=2

Joseph Cheek wrote:
> 
> 2.4.3-pre4.
> 
> i also see a reference to KMALLOC_MAXSIZE in
> drivers/net/hamradio/6pack.c
> 
> this kernel won't compile, is KMALLOC_MAXSIZE set somewhere?  i can't
> find it.  is it deprecated?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
