Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318794AbSHWNJd>; Fri, 23 Aug 2002 09:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSHWNJd>; Fri, 23 Aug 2002 09:09:33 -0400
Received: from [213.191.86.30] ([213.191.86.30]:17795 "EHLO nox.lemuria.org")
	by vger.kernel.org with ESMTP id <S318794AbSHWNJd>;
	Fri, 23 Aug 2002 09:09:33 -0400
Date: Fri, 23 Aug 2002 15:13:43 +0200
From: Tom <tom@lemuria.org>
To: linux-kernel@vger.kernel.org
Subject: Re: page_alloc bug
Message-ID: <20020823151343.A15667@lemuria.org>
References: <20020823090527.A7715@lemuria.org> <20020823125734.GA8854@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020823125734.GA8854@www.kroptech.com>; from akropel1@rochester.rr.com on Fri, Aug 23, 2002 at 08:57:34AM -0400
X-message-flag: Outlook: A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 08:57:34AM -0400, Adam Kropelin wrote:
> > EIP: 0010:[<c012b96d>] Tainted: P
>                                   ^
> What proprietary modules did you have loaded when this BUG() was hit? nVidia,
> perhaps? Reproduce the problem from a cold boot without ever having loaded the
> closed-source module(s). If you can't, go talk to whomever made the module; the
> community cannot help you solve a problem when we can't see the code.

Several people told me so. I will do that and see if the bug reappears.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5
