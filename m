Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUIATrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUIATrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIATrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:47:33 -0400
Received: from [195.23.16.24] ([195.23.16.24]:40098 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267450AbUIAToY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:44:24 -0400
Message-ID: <41362694.9070101@grupopie.com>
Date: Wed, 01 Sep 2004 20:44:20 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
References: <4134DEF4.8090001@grupopie.com> <1094016277.17828.53.camel@bach> <4135AFBE.1000707@grupopie.com> <20040901192755.GC7219@mars.ravnborg.org>
In-Reply-To: <20040901192755.GC7219@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.40; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> ...
> 
> When you have made the split Rusty requested and implemented
> the above could you please send patches to me. I will add them to
> my kbuild queue.

I'd be glad to do this, but AFAICT the patch already entered the mm
tree, so I think that splitting it now, or sending it through a
different path would probably add to the confusion I already
managed to create :(

Implementing the "type char" should be a single patch on top of this
one, though. I'll be sure to CC you when I post it (probably today).

Thanks,

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
