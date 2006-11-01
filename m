Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752288AbWKASuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWKASuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbWKASuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:50:19 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:20414 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1752288AbWKASuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:50:17 -0500
Date: Wed, 1 Nov 2006 18:50:36 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Thomas Koeller <thomas@koeller.dyndns.org>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       "Randy. Dunlap" <rdunlap@xenotime.net>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20061101185036.GD4736@linux-mips.org>
References: <20061101184633.GA7056@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101184633.GA7056@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 07:46:33PM +0100, Wim Van Sebroeck wrote:

> Thomas: I moved start and stop code into seperate functions. I also
> deleted the #include <rm9k_wdt.h> because the file doesn't exist.

You just didn't see it, include/asm-mips/mach-excite/rm9k_wdt.h.

  Ralf
