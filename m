Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVHDOln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVHDOln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVHDOjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:39:06 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:34692 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262519AbVHDOgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:36:37 -0400
Message-ID: <42F227D9.8000405@gmail.com>
Date: Thu, 04 Aug 2005 16:36:09 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Old api files, rewrite or delete?
References: <42F20345.3020603@gmail.com> <20050804144331.E32154@flint.arm.linux.org.uk>
In-Reply-To: <20050804144331.E32154@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King napsal(a):

>On Thu, Aug 04, 2005 at 02:00:05PM +0200, Jiri Slaby wrote:
>  
>
>>drivers/parport/parport_pc.c
>>    
>>
>
>I think a fair number of people probably use this.
>  
>
Yeah, I use it too, i don't know, why am I asking for this.

>>REMOVE:
>>drivers/video/pm3fb.c
>>    
>>
>
>I have one of these cards, and I believe it's only recently (2.5-ish)
>been merged.  Why are you so keen to mark it as "remove"?
>  
>
Because it doesn't work for me (it doesn't compile) and it is marked as 
"broken".
Where are files fbcon-cfb{2,4,8,16,24,32}.h? Do you need some additional 
packages?
-- then a few lines should be added to Kconfig.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

