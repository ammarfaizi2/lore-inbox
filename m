Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUILWDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUILWDC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 18:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUILWDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 18:03:02 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:9430 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261875AbUILWDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 18:03:00 -0400
Date: Sun, 12 Sep 2004 23:59:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Sean Neakums <sneakums@zork.net>
Cc: jgarzik@pobox.com, akpm@osdl.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4: r8169: irq 16: nobody cared!/TX Timeout
Message-ID: <20040912215933.GB27282@electric-eye.fr.zoreil.com>
References: <6upt4s4cro.fsf@zork.zork.net> <20040912110614.GA20942@electric-eye.fr.zoreil.com> <6u8ybf2w3f.fsf@zork.zork.net> <20040912204319.GA27282@electric-eye.fr.zoreil.com> <6uisaj19m4.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uisaj19m4.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> :
> Francois Romieu <romieu@fr.zoreil.com> writes:
> > Sean Neakums <sneakums@zork.net> :
> > [...]
> >> Unfortunately after tonight I won't have access to this machine until
> >> Friday evening.  I'll grab the netdev patchset and try those next.
> >
> > via686a based multiprocessor board and acpi...
> >
> > Can you try vanilla 2.6.8 r8169 driver with 2.6.9-rc1-mm4 ?
> 
> Same result on starting X:
> 
> irq 16: nobody cared!

It slightly sounds like a broken irq routing.

Any taker for the hot potato ?

--
Ueimor
