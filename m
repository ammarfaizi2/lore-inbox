Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275303AbTHMTKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275305AbTHMTKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:10:52 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:25357 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S275303AbTHMTKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:10:51 -0400
Date: Wed, 13 Aug 2003 16:10:52 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.22-rc2 fix warnings deprecated in fs/ntfs
Message-Id: <20030813161052.04860fb4.vmlinuz386@yahoo.com.ar>
In-Reply-To: <Pine.LNX.4.44.0308131141050.4279-100000@localhost.localdomain>
References: <20030813054747.1dde3a87.vmlinuz386@yahoo.com.ar>
	<Pine.LNX.4.44.0308131141050.4279-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 11:41:46 -0300 (BRT), Marcelo Tosatti wrote:
>
>
>On Wed, 13 Aug 2003, Gerardo Exequiel Pozzi wrote:
>
>> Hi Marcelo,
>> 
>> I created a patch that fix these warnings in gcc 3.2, please apply
>it.
>
>Gerardo, 
>
>The patch looks good but I wont apply it now. I prefer getting it
>throught the NTFS maintainer. Can you send this to him? 
>

Thanks for you response, ok, now I am going to create one second part
that corrects around 100 warnings (the same deprecated) when option
DEBUG in the Makefile activates, and send to Anton Altaparmakov, so
that it is contacted with you.

Best regards,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
