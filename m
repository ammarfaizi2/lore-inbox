Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318914AbSICUmi>; Tue, 3 Sep 2002 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318916AbSICUmi>; Tue, 3 Sep 2002 16:42:38 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:24035 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318914AbSICUmh>;
	Tue, 3 Sep 2002 16:42:37 -0400
Date: Tue, 3 Sep 2002 13:47:09 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: smc-ircc freeze kernel
Message-ID: <20020903204709.GC19839@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler wrote :
> 
> ifconfig irda0 192.168.1.1 netmask 255.255.255.0
> my kernel freeze after 3 seconds and only numlock and scrolllock blinks

	Yeah, obviously it should not crash when the user make a
mistake, but I expect tracking this bug to be non-trivial.
	BTW : There is a Linux-IrDA mailing list for all your general
IrDA question, a Linux-IrDA howto, and my web page.
	Regards,

	Jean

