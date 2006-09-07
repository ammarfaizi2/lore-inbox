Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWIGQVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWIGQVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWIGQVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:21:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:27637 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932260AbWIGQVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:21:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nkD7rXGtX5Fo2+kDkpvoP4MjnidF8hxxvVqU78XehyjhvH0MyQHxkkw3J1WW1Zf+95JpsZ5ycyHuNn5Z8xpJcdk5SAnrRh03kOJKZsWb6AL381D/mT3tjPuWk0qJiatJJpJudocrHBcYQr77rbdlLkZ6bZfcLuMOM7+SXDsCPjw=
Message-ID: <9e0cf0bf0609070921k7a96f9f7x1605a66745feef9f@mail.gmail.com>
Date: Thu, 7 Sep 2006 19:21:17 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Haavard Skinnemoen" <hskinnemoen@atmel.com>
Subject: Re: [PATCH 05/26] Dynamic kernel command-line - avr32
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       avr32@atmel.com
In-Reply-To: <20060907093111.1bf57c61@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609040115.22856.alon.barlev@gmail.com>
	 <200609040118.06291.alon.barlev@gmail.com>
	 <20060907093111.1bf57c61@cad-250-152.norway.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/06, Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> (trimming Cc list)
>
> On Mon, 4 Sep 2006 01:18:04 +0300
> Alon Bar-Lev <alon.barlev@gmail.com> wrote:
>
> >
> > 1. Rename saved_command_line into boot_command_line.
> > 2. Set command_line as __initdata.
>
> Thanks. Seems to work fine with my setup.
>
> I should probably start using that parse_early_param() stuff, though.
> I'll update this patch if I do.
>
> Now, do I add a signed-off-by line here, or an acked-by?
>
> Haavard


Thanks for checking the patch!!!

Best Regards,
Alon Bar-Lev.
