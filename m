Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVAKLNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVAKLNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 06:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVAKLNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 06:13:09 -0500
Received: from imap3.nextra.sk ([195.168.1.92]:41988 "EHLO tic.nextra.sk")
	by vger.kernel.org with ESMTP id S262716AbVAKLM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 06:12:59 -0500
Message-ID: <41E3B4FE.8000507@rainbow-software.org>
Date: Tue, 11 Jan 2005 12:14:06 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Pierre Ossman <drzeus-list@drzeus.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stephen_pollei@comcast.net, rmk+lkml@arm.linux.org.uk
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
References: <20050110184307.GB2903@stusta.de> <1105382033.12054.90.camel@localhost.localdomain> <41E2F1BD.1020407@drzeus.cx> <20050110220426.GF2903@stusta.de> <41E3001C.6020304@drzeus.cx> <20050110224238.GB29578@stusta.de>
In-Reply-To: <20050110224238.GB29578@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Thinking about it:
> mailout.stusta.mhn.de has two IP addresses.
> Do you try some lookups of it's 10.150.127.10 address???

That's a private class A IP address which should never appear on the 
internet. Looks like DNS configuration is broken somewhere.

-- 
Ondrej Zary
