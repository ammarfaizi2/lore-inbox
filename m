Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVHZPFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVHZPFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVHZPFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:05:04 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60381 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965068AbVHZPFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:05:02 -0400
Message-Id: <200508261503.j7QF3vpA014777@laptop11.inf.utfsm.cl>
To: robotti@godmail.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS! 
In-Reply-To: Message from robotti@godmail.com 
   of "Thu, 25 Aug 2005 11:34:01 -0400." <200508251534.j7PFY11g024729@ms-smtp-01.rdc-nyc.rr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 26 Aug 2005 11:03:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

robotti@godmail.com wrote:
>    >On Thu, Aug 25, 2005 at 12:35:22AM -0400, robotti@xxxxxxxxxxx wrote:
>    >I don't know, because tar is probably more widely used and
>    >consequently people are more familiar with how to use it.
>    >>As I said before, the cpio format is cleaner/easier to parse in the
>    >>kernel. Everyone has cpio probably so using tar isn't necessary.
> 
> Cpio is perhaps as available as tar, but it's not as used as tar.
> 
> Unless tar would be inordinately larger than a cpio implementation
> (I can't imagine, but I'm not a coder!) I would prefer it.

There are literaly dozens of "tar" formats around, cpio is much more
standardized (and simpler).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
