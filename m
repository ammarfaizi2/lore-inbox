Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVKVDkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVKVDkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVKVDkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:40:47 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:20111 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750933AbVKVDkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:40:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git pull 00/14] Input updates for 2.6.15
Date: Mon, 21 Nov 2005 22:40:42 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Miloslav Trmac <mitr@volny.cz>
References: <20051120063611.269343000.dtor_core@ameritech.net> <200511201242.08506.dtor_core@ameritech.net> <Pine.LNX.4.64.0511201016220.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511201016220.13959@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511212240.42532.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 13:17, Linus Torvalds wrote:
> 
> On Sun, 20 Nov 2005, Dmitry Torokhov wrote:
> > 
> > That cinergyT2 fix (from Linux-2.6.15-rc2 thread) - do you already have it
> > or would you prefer a pull prepared later tonight?
> 
> The only one I have is the one I got through davem a couple of days ago: 
> 
>   cinergyT2: cinergyt2_register_rc() should return 0 on success
> 
> is that the one you're talking about?
> 

Sorry for the delay...

I see that you already merged the patch I was talking about:

db93a82fa9d8b4d6e31c227922eaae829253bb88 [PATCH] Fix an OOPS is CinergyT2

-- 
Dmitry
