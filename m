Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUHSP7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUHSP7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUHSP7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:59:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:64701 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266535AbUHSP7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:59:17 -0400
Message-Id: <200408191558.i7JFwxw0004307@laptop14.inf.utfsm.cl>
To: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Firmware Loader is orphan 
In-Reply-To: Message from =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es> 
   of "Thu, 19 Aug 2004 02:18:46 +0200." <4123F1E6.2080308@hispalinux.es> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 19 Aug 2004 11:58:59 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es> said:
> The author and maintainer of the firmware loader died on May.

Sorry to hear that.

>                                                               I think 
> this little piece is very important for the kernel. Anybody is taking 
> care of firmware loader?

> --------------030001090603060008040701
> Content-Type: text/plain;
>  name="firmware_loader_orphan.patch"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline;
>  filename="firmware_loader_orphan.patch"
> 
> --- linux-2.6-rrey/MAINTAINERS.orig	2004-08-19 01:57:52.405537120 +0200
> +++ linux-2.6-rrey/MAINTAINERS	2004-08-19 02:05:25.001988245 +0200
> @@ -822,10 +822,8 @@
>  S:	Maintained
>  
>  FIRMWARE LOADER (request_firmware)
> -P:	Manuel Estrada Sainz
> -M:	ranty@debian.org
>  L:	linux-kernel@vger.kernel.org
> -S:	Maintained
> +S:	Orphan

I's move the data (at least the name) to a THANKS (or some such) file for
people who left as maintainers (for whatever reason). I think they deserve
our lasting gratitude.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
