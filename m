Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932775AbWE1GHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbWE1GHk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 02:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWE1GHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 02:07:40 -0400
Received: from 8.ctyme.com ([69.50.231.8]:467 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932775AbWE1GHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 02:07:40 -0400
Message-ID: <44793E2B.2050100@perkel.com>
Date: Sat, 27 May 2006 23:07:39 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
References: <44793100.50707@perkel.com>
In-Reply-To: <44793100.50707@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Perkel wrote:
> Is there a problem with the forcedeth driver not being compatible with 
> the Asus K8N-VM motherboard? I installed Fedora Core 5 and the 
> Ethernet doesn't want to work. I installed the latest FC5 kernel which 
> is some flavor og 2.6.16 and it still doesn't work. The FC4 CD and 
> rescue disk don't work either. Windows XP however does work so I know 
> that hardware is good.
>
> lspci says the hardware is an nVidia MCP51 ethernet controller. What 
> am I missing?
>
> Thanks in advance.
>

Also - why is it that I can load a 3 year old version of Windows XP on 
this motherboad and it just work but I load a modern Linux Kernel and it 
can't find the Ethernet card?

