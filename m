Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161490AbWJKVcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161490AbWJKVcL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161513AbWJKVb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:31:59 -0400
Received: from xenotime.net ([66.160.160.81]:54410 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161490AbWJKVbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:31:44 -0400
Date: Wed, 11 Oct 2006 14:33:06 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maintainers: add me to isicom, mxser
Message-Id: <20061011143306.e3ae39f8.rdunlap@xenotime.net>
In-Reply-To: <8974328973221213@karneval.cz>
References: <8974328973221213@karneval.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 23:14:27 +0200 (CEST) Jiri Slaby wrote:

> maintainers: add me to isicom, mxser
> 
> I can maintain moxa and isicom char drivers, because I've rewritten them to
> the new API.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
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

L: (mailing list) too, please.

> +MULTITECH MULTIPORT CARD (ISICOM)
> +P:	Jiri Slaby
> +M:	jirislaby@gmail.com
> +S:	Maintained


---
~Randy
