Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262133AbSJNTdC>; Mon, 14 Oct 2002 15:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262125AbSJNTdC>; Mon, 14 Oct 2002 15:33:02 -0400
Received: from rom.cscaper.com ([216.19.195.129]:29844 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S262118AbSJNTdB>;
	Mon, 14 Oct 2002 15:33:01 -0400
Subject: Re: Known 'issues' about 2.4.19...
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
From: "Joseph N. Hall" <joseph@5sigma.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 14 Oct 2002 12:41 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20021014193301Z262118-32597+1769@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [...] I recently found out its IDE
> subsystem doesn't get along too well with VIA chipsets (replaced my old
> mobo for a VT8233 based recently and probls started surfacing).

Personally the best stability I've had lately is with 2.4.17.

I was never able to get IDE working right on my KT333 based Soyo
Dragon Ultra Platinum under 2.4.19 or later.  Swapped it for
an iWill (ALi), but "I will" try the Soyo again later because 
it's a nicer board ...  I forget whether the problems went back
to 2.4.18 or not.

Also my dual CPU pIII box (ASUS CUV4X-DLS) freezes silently after 
1-3 days uptime running a redhat style (modular) 2.4.18+ kernel.  
I reverted to a mostly monolithic 2.4.17 and have > 1 week of uptime 
... I will see sometime if a newer monolithic kernel will fly.

  -joseph

