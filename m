Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264497AbRFUBdF>; Wed, 20 Jun 2001 21:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264510AbRFUBc4>; Wed, 20 Jun 2001 21:32:56 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58639 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264497AbRFUBck>; Wed, 20 Jun 2001 21:32:40 -0400
Date: Wed, 20 Jun 2001 20:58:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Justin Guyett <justin@soze.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freeze with 2.4.5-ac16
In-Reply-To: <Pine.LNX.4.33.0106201527120.29004-100000@gw.soze.net>
Message-ID: <Pine.LNX.4.21.0106202058050.13709-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Jun 2001, Justin Guyett wrote:

> On Wed, 20 Jun 2001, Justin Guyett wrote:
> 
> > I got it to freeze in console (two generic find / -type f / type d), one
> > process allocating and writing 0 to 192mb
> >
> > machine responds to pings, switching VTs works
> >
> > (256 physical, 512 swap)
> 
> happened again (vt1 and 2 echo but shells are unresponsive, vt3+ don't
> echo) only active process was the program allocating 192mb and writing to
> it, no find this time.

Can you get the backtrace of this process?

