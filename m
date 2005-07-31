Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVGaMhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVGaMhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 08:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263218AbVGaMhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 08:37:25 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:25872 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261732AbVGaMhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 08:37:23 -0400
Message-ID: <42ECC601.3030702@superbug.co.uk>
Date: Sun, 31 Jul 2005 13:37:21 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050729)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-mm1
References: <20050731020552.72623ad4.akpm@osdl.org> <6f6293f105073103045fd32d61@mail.gmail.com> <20050731101923.GL5590@stusta.de>
In-Reply-To: <20050731101923.GL5590@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Jul 31, 2005 at 12:04:59PM +0200, Felipe Alfaro Solana wrote:
> 
> 
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/
>>
>>Why was the KERNEL_VERSION(a,b,c) macro removed from
>>include/linux/version.h? The removal breaks external drivers like
> 
> 
> It moved to a different header file.
> 
> 
>>NDISWRAPPER or nVidia propietary.
> 
> 
> That's their problem.
> 
> cu
> Adrian
> 

Where have they moved to?
This will break ALSA as well.

