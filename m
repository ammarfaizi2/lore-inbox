Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271841AbRIMQm7>; Thu, 13 Sep 2001 12:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRIMQmt>; Thu, 13 Sep 2001 12:42:49 -0400
Received: from www.transvirtual.com ([206.14.214.140]:2314 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S271834AbRIMQmh>; Thu, 13 Sep 2001 12:42:37 -0400
Date: Thu, 13 Sep 2001 09:42:43 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: tushar korde <tushar_k5@rediffmail.com>, linux-kernel@vger.kernel.org
Subject: Re: suggest project
In-Reply-To: <20010913144253.T11046@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.10.10109130936180.23464-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    Find out why Linux PS/2 keyboard and mouse drivers don't support
>    disconnect, and reconnect of said devices.   Then fix things so
>    that keyboard can be replugged at any time, and it gets into
>    sensible state, same with the mouse.
> 
>    This is especially serious nuisance while running X-window system,
>    which of course uses raw keyboard events.  (But that should not matter
>    at the low-level driver, which should handle the reconnect issue.)

This has been fixed for some time with the input api drivers we have had
in CVS. 

