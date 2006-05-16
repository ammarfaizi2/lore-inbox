Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWEPQBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWEPQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWEPQBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:01:24 -0400
Received: from xenotime.net ([66.160.160.81]:13442 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932108AbWEPQAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:00:51 -0400
Date: Tue, 16 May 2006 09:03:15 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: Clarify maintainers and include linux-security info
Message-Id: <20060516090315.421e5166.rdunlap@xenotime.net>
In-Reply-To: <1147795421.2151.80.camel@localhost.localdomain>
References: <1147795421.2151.80.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 17:03:41 +0100 Alan Cox wrote:

> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> --- linux-2.6.17-rc4/MAINTAINERS~	2006-05-16 16:38:42.034901424 +0100
> +++ linux-2.6.17-rc4/MAINTAINERS	2006-05-16 16:38:42.034901424 +0100
> @@ -44,7 +44,11 @@
>  	do changes at work you may find your employer owns the patch
>  	not you.
>  
> -7.	Happy hacking.
> +7.	When sending security related changes or reports to a maintainer
> +	please Cc: linux-security@kernel.org, especially if the maintainer
> +	does not respond.

It's just security@kernel.org according to MAINTAINERS.

> +8.	Happy hacking.



---
~Randy
