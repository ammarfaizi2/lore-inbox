Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWEaRKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWEaRKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 13:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWEaRKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 13:10:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61571 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751737AbWEaRKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 13:10:08 -0400
Date: Wed, 31 May 2006 10:13:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Raphael Assenat <raph@raphnet.net>
Cc: ijc@hellion.org.uk, alessandro.zummo@towertech.it,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add max6902 RTC support
Message-Id: <20060531101349.1f5d816f.akpm@osdl.org>
In-Reply-To: <20060531124333.GA945@aramis.lan.raphnet.net>
References: <20060530150913.GE797@aramis.lan.raphnet.net>
	<20060530203241.4a4de734@inspiron>
	<20060530184949.GF797@aramis.lan.raphnet.net>
	<20060530150143.7e39dac3.akpm@osdl.org>
	<1149057131.7461.40.camel@localhost.localdomain>
	<20060530235500.edc9ef49.akpm@osdl.org>
	<20060531124333.GA945@aramis.lan.raphnet.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 08:43:34 -0400
Raphael Assenat <raph@raphnet.net> wrote:

> The compulab code comes from the kernel patch the produce for their
> cn-x255 board. (inside a zip file on the 
> http://www.compulab.co.il/x255/html/x255-developer.htm)
> 
> The original file (drivers/char/max6902.c) was GPL, which is of course
> an appropriate licence:
> 
> /*
>  * max6902.c
>  *
>  * Driver for MAX6902 RTC
>  *
>  * Copyright (C) 2004 Compulab Ltd.
>  *
>  * 
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License version 2 as
>  * published by the Free Software Foundation.
>  *
>  *
>  */
> 
> For reference, you can get the original file here:
> http://raph.people.8d.com/misc/max6902.c

Wonderful, thanks.
