Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbVJEJkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVJEJkY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 05:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVJEJkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 05:40:24 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:11231 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965088AbVJEJkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 05:40:23 -0400
Message-ID: <43439FF0.9050506@aitel.hist.no>
Date: Wed, 05 Oct 2005 11:42:08 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Michon <pierre@no-spam.org>
CC: linux-kernel@vger.kernel.org, legal@lists.gpl-violations.org
Subject: Re: freebox possible GPL violation
References: <20051005084738.GA29944@linux.ensimag.fr>
In-Reply-To: <20051005084738.GA29944@linux.ensimag.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Michon wrote:

>==FREE and PRO-FREE CLAIMS (some claims could be find on [6])==
>
>A) The freebox is only lended, so the user can't ask for GPL source code.
>  
>
If you lend someone linux, you're _distributing_ linux. The
GPL is about _distribution_ I believe, it doesn't have to be a _sale_.

You can't _lend_ someone windows (as a way of doing business) without
satisfying ms licencing terms either.

>-> They forgot that for wifi feature, you have buy a pcmcia card and 
>that is card works wifi Linux driver. So according to GPL you could ask 
>for wifi driver source code and all the Linux source code ???
>  
>
Well, the wifi driver may or may not be under the GPL licence.
Check that first.  The linux kernel itself is GPL of course.

>Also some people that don't return the freebox in time had to 
>paid 400 Euros and they became the owner of the freebox. Free send to a 
>client a letter [7] saying that if the user don't return the freebox, 
>free could bill it and then it becomes propriety of the user : 
>'Nous vous rappelons que conformément aux Conditions Générales de Vente , 
>en cas de non-restitution du modem, Free se réserve le droit de procéder 
>à la facturation de l'équipement terminal, au prix mentionné dans les CGV, 
>qui deviendra alors la *propriété* de l'Usager.'
>
>
>B) The freebox don't keep the Linux kernel in memory, it is downloaded 
>at each boot.
>  
>
Check where it is downloaded from, that is where linux
is being distributed from. Likely the same company though.

>C) 'Free' is a network operator and needs to keep secret some informations 
>in order to preserve security on its networks.
>  
>
They don't need to keep the kernel secret for security.  Of course they 
can still
keep their scripts secret, their (non-GPL) userland utilities secret, their
proprietary drivers secret and the hw specs secret. Good or bad, it is
up to them.  But it seems to me they have to offer the kernel source,
at least.

Helge Hafting
