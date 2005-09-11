Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVIKWVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVIKWVS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVIKWVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:21:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750972AbVIKWVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:21:17 -0400
Date: Sun, 11 Sep 2005 15:20:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/char/isicom old api rewritten (round 2)
Message-Id: <20050911152045.7ca42491.akpm@osdl.org>
In-Reply-To: <4324A9F5.3020702@gmail.com>
References: <43236A02.9070301@gmail.com>
	<20050910165356.1ddbcc0c.akpm@osdl.org>
	<4324A9F5.3020702@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> wrote:
>
> Andrew Morton wrote:
> 
> >Jiri Slaby <jirislaby@gmail.com> wrote:
> >  
> >
> >>This patch removes old api in pci probing and replaces it with new.
> >> Firmware loading added.
> >>    
> >>
> >> Patch is here for its size (40 KiB):
> >> http://www.fi.muni.cz/~xslaby/lnx/isi_main.txt
> >>    
> >>
> >
> >40k isn't large - please include such patches in the email.
> >  
> >
> Thank you, Andrew, for your reply and hints, you sent.
> 

Did everything get addressed?

> 
> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> 
>  drivers/char/isicom.c  | 2005 
> ++++++++++++++++++++++++-------------------------
>  include/linux/isicom.h |   53 -
>  2 files changed, 1004 insertions(+), 1054 deletions(-)

Please fix your email client's wordwrapping problem.

> Now, it is 80k:
> 
> http://www.fi.muni.cz/~xslaby/lnx/isicom.txt

Then send the patch, cc'ed to the mailing list as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, thanks.

