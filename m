Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSKZUBB>; Tue, 26 Nov 2002 15:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbSKZUBA>; Tue, 26 Nov 2002 15:01:00 -0500
Received: from [195.39.17.254] ([195.39.17.254]:15620 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266637AbSKZUA4>;
	Tue, 26 Nov 2002 15:00:56 -0500
Date: Tue, 26 Nov 2002 14:35:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [RFC] hangcheck-timer module
Message-ID: <20021126133547.GA1268@zaurus>
References: <20021121201931.GH770@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121201931.GH770@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [ Feh, forgot to attach the damned file. ]

:-)

> 	The module is currently used in a cluster environment.  After
> some time out to lunch, the rest of the cluster will have given up on a
> machine.  If the machine suddenly comes back and assumes it is still
> "live", bad things can happen.

Would it make it more sense for other machines
to "kill" offending machine (cut power or press reset)?


-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

