Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbTLRXXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbTLRXXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:23:12 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:62081
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265399AbTLRXXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:23:06 -0500
Date: Thu, 18 Dec 2003 18:22:16 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Karim Yaghmour <karim@opersys.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updating real-time and nanokernel maintainers
In-Reply-To: <3FE234E4.8020500@opersys.com>
Message-ID: <Pine.LNX.4.58.0312181821270.19491@montezuma.fsmlabs.com>
References: <3FE234E4.8020500@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Karim Yaghmour wrote:

> diff -urN linux-2.6.0/MAINTAINERS linux-2.6.0-correct-maintainers/MAINTAINERS
> --- linux-2.6.0/MAINTAINERS	2003-12-17 21:58:57.000000000 -0500
> +++ linux-2.6.0-correct-maintainers/MAINTAINERS	2003-12-18 14:21:49.000000000 -0500
> @@ -181,6 +181,13 @@
>   W:	http://www.tu-darmstadt.de/~tek01/projects/linux.html
>   S:	Maintained
>
> +ADEOS: ADAPTIVE DOMAIN ENVIRONMENT FOR OPERATING SYSTEMS
> +P:	Philippe Gerum
> +M:	rpm@xenomai.org
> +L:	adeos-main@nongnu.org
> +W:	www.adeos.org
> +S:	Maintained
> +
>   ADVANSYS SCSI DRIVER
>   P:	Bob Frey
>   M:	linux@advansys.com
> @@ -1664,11 +1671,11 @@
>   L:	linux-kernel@vger.kernel.org
>   S:	Maintained
>
> -RTLINUX  REALTIME  LINUX
> -P:	Victor Yodaiken
> -M:	yodaiken@fsmlabs.com
> -L:	rtl@rtlinux.org
> -W:	www.rtlinux.org
> +RTAI: REAL-TIME APPLICATION INTERFACE
> +P:	Paolo Mantegazza
> +M:	mantegazza@aero.polimi.it
> +L:	rtai-dev@rtai.org
> +W:	www.aero.polimi.it/~rtai/
>   S:	Maintained

I'd say take them both out, neither have code in the kernel.
