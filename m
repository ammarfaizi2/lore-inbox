Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTILSWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTILSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:21:13 -0400
Received: from [65.248.4.67] ([65.248.4.67]:18651 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261839AbTILSUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:20:51 -0400
Message-ID: <000f01c3795b$03b22fe0$980210ac@forumci.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Chris Wright" <chrisw@osdl.org>
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
References: <004801c390bd$55cca700$f8e4a7c8@bsb.virtua.com.br> <20030912104114.B21503@build.pdx.osdl.net>
Subject: Re: Stack size
Date: Fri, 12 Sep 2003 15:23:47 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a test in kernel to know how much memory is consumed by stack ?

Breno
----- Original Message -----
From: "Chris Wright" <chrisw@osdl.org>
To: "Breno" <brenosp@brasilsec.com.br>
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
Sent: Friday, September 12, 2003 2:41 PM
Subject: Re: Stack size


> [Hey, any chance you could join us in September? ;-) "Date:   Sun, 12 Oct
> 2003 13:35:33 +0100"]
>
> * Breno (brenosp@brasilsec.com.br) wrote:
> > What happen when stack increase more than 8mb ?
>
> Memory corruption.
> -chris
> --
> Linux Security Modules     http://lsm.immunix.org
http://lsm.bkbits.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

