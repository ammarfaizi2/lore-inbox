Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVHHWtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVHHWtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVHHWtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:49:21 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49424 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932332AbVHHWtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:49:20 -0400
Date: Tue, 9 Aug 2005 00:49:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] Removing maintainer's bad e-mails
Message-ID: <20050808224917.GP4006@stusta.de>
References: <42F69E53.40602@gmail.com> <20050808183300.GB26182@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808183300.GB26182@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 02:33:00PM -0400, Dave Jones wrote:
> On Mon, Aug 08, 2005 at 01:50:43AM +0200, Jiri Slaby wrote:
> 
>  > diff --git a/MAINTAINERS b/MAINTAINERS
>  > --- a/MAINTAINERS
>  > +++ b/MAINTAINERS
>  > @@ -204,8 +204,6 @@ S:	Maintained
>  > 
>  > ADVANSYS SCSI DRIVER
>  > P:	Bob Frey
>  > -M:	linux@advansys.com
>  > -W:	http://www.advansys.com/linux.html
>  > L:	linux-scsi@vger.kernel.org
>  > S:	Maintained
> 
> You may as well change the S: to unmaintained whilst
> you're there, it hasn't seen any updates in a long time,
> and still uses several out-of-date SCSI APIs.

Or he could completely remove the entry.

We don't have entries for every single unmaintained driver, and the 
smaller MAINTAINERS is the higher is the possibility of not missing a 
relevant entry when checking whom to send an email.

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

