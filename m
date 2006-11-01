Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992714AbWKATLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992714AbWKATLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992720AbWKATLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:11:19 -0500
Received: from outmx014.isp.belgacom.be ([195.238.4.69]:51947 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S2992714AbWKATLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:11:18 -0500
Date: Wed, 1 Nov 2006 20:11:12 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Koeller <thomas@koeller.dyndns.org>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       "Randy. Dunlap" <rdunlap@xenotime.net>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20061101191112.GB7056@infomag.infomag.iguana.be>
References: <20061101184633.GA7056@infomag.infomag.iguana.be> <20061101185036.GD4736@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101185036.GD4736@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

> > Thomas: I moved start and stop code into seperate functions. I also
> > deleted the #include <rm9k_wdt.h> because the file doesn't exist.
> 
> You just didn't see it, include/asm-mips/mach-excite/rm9k_wdt.h.

Thanks, didn't see it indeed :-). I'll include that again.
Any other remarks still?

Greetings,
Wim.

