Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161539AbWJKVyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161539AbWJKVyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161540AbWJKVyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:54:08 -0400
Received: from xenotime.net ([66.160.160.81]:30105 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161539AbWJKVyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:54:04 -0400
Date: Wed, 11 Oct 2006 14:55:30 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH try2] maintainers: add me to isicom, mxser
Message-Id: <20061011145530.1762a4e5.rdunlap@xenotime.net>
In-Reply-To: <89743ewww3221213@karneval.cz>
References: <20061011143306.e3ae39f8.rdunlap@xenotime.net>
	<89743ewww3221213@karneval.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 23:45:02 +0200 (CEST) Jiri Slaby wrote:

> Randy Dunlap wrote:
> > On Wed, 11 Oct 2006 23:14:27 +0200 (CEST) Jiri Slaby wrote:
> >> +MOXA SMARTIO/INDUSTIO SERIAL CARD (MXSER 2.0)
> >> +P:	Jiri Slaby
> >> +M:	jirislaby@gmail.com
> >> +S:	Maintained
> >> +
> >
> >L: (mailing list) too, please.
> 
> Ok, thanks, here is a corrected patch.

Did you resend the version 1 patch instead??

> --
> 
> maintainers: add me to isicom, mxser
> 
> I can maintain moxa and isicom char drivers, because I've rewritten them to
> the new API.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit d2feb2fd87cc5e7db4cd8e8ddd910d9d2d6cebf1
> tree 664ff80a517947d6766d80da81e8421eae1f6825
> parent b2090dd621f58423950e8e79b0959889d26a8227
> author Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 23:09:49 +0200
> committer Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 23:09:49 +0200
> 
>  MAINTAINERS |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c4563ce..97beb1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2020,6 +2020,11 @@ M:	rubini@ipvvis.unipv.it
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  
> +MOXA SMARTIO/INDUSTIO SERIAL CARD (MXSER 2.0)
> +P:	Jiri Slaby
> +M:	jirislaby@gmail.com
> +S:	Maintained
> +
>  MSI LAPTOP SUPPORT
>  P:	Lennart Poettering
>  M:	mzxreary@0pointer.de
> @@ -2042,6 +2047,11 @@ P:	Andrew Veliath
>  M:	andrewtv@usa.net
>  S:	Maintained
>  
> +MULTITECH MULTIPORT CARD (ISICOM)
> +P:	Jiri Slaby
> +M:	jirislaby@gmail.com
> +S:	Maintained
> +
>  NATSEMI ETHERNET DRIVER (DP8381x)
>  P: 	Tim Hockin
>  M:	thockin@hockin.org
> 


---
~Randy
