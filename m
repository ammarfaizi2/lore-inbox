Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVASSH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVASSH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVASSH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:07:58 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:14791 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S261804AbVASSHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:07:52 -0500
Message-ID: <41EEA1C7.7060802@jonmasters.org>
Date: Wed, 19 Jan 2005 18:07:03 +0000
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
CC: David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>,
       Olaf Hering <olh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] raid6: altivec support
References: <1106120622.10851.42.camel@baythorne.infradead.org> <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
In-Reply-To: <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:

> We did talk about looking at using some work Ben did in ppc64 with OF in 
> ppc32.  John Masters was looking into this, but I havent heard much from 
> him on it lately.

I went rather quiet since I had nothing new to add to the discussion. 
But I did plan to get somewhere before FOSDEM (next month) so I could at 
least talk to the guys there about it - this is really taking a backseat 
as I've little time for it and no BDI2000/etc. at home :-)

> The firmware interface on the ppc32 embedded side is some what broken in 
> my mind.

It's absolutely broken and needs fixing - perhaps if someone wants to 
work with me on it, we'd get it sorted more quickly.

Cheers,

Jon.
