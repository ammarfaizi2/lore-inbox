Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbTIIDpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 23:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbTIIDpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 23:45:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40323 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263926AbTIIDpB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 23:45:01 -0400
Message-ID: <3F5D4CB1.3060001@pobox.com>
Date: Mon, 08 Sep 2003 23:44:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: John Cherry <cherry@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5 (compile stats)
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <1063065853.10623.449.camel@cherrypit.pdx.osdl.net>
In-Reply-To: <1063065853.10623.449.camel@cherrypit.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cherry wrote:
> Compile statistics: 2.6.0-test5
> Compiler: gcc 3.2.2
> Script: http://developer.osdl.org/~cherry/compile/compregress.sh
> 
> Note: the numbers look drastically better, but this is skewed
>       by the fact that CONFIG_CLEAN_COMPILE is now the default
>       for defconfig and allmodconfig.
> 
>                bzImage       bzImage        modules
>              (defconfig)  (allmodconfig) (allmodconfig)


Any chance you can add "bzImage (allyesconfig)"?

Cool stats, thanks.

	Jeff



