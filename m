Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752386AbWKBNoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbWKBNoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbWKBNoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:44:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:56475 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752386AbWKBNoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:44:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kvSy6BOmklNtc76St6Rv/7aI9glENT1wI8NSZOKVwewKPFPweGkFHyk/GQGajNZO7Vhzsmj+jnvwWbm61brDvQrT5Wo3DakJh6+QdE07BSDYXriF1ovL9tFGQTh7vFWdKGzsamF3gvJc2Ig7sgv6QTKIdTmKy8aIGx3eoSpYOi4=
Message-ID: <653402b90611020544l6e5ded94hc4c932fc1442fcb0@mail.gmail.com>
Date: Thu, 2 Nov 2006 14:44:16 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH update6] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <4549B19C.70304@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061101014057.454c4f43.maxextreme@gmail.com>
	 <4549B19C.70304@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Hi
>
> Miguel Ojeda Sandonis wrote:
> > Andrew, here it is the coding style fixes. Thanks you.
> >
> > I think the driver is getting ready for freeze until
> > 2.6.20-rc1 (if anyone sees something wrong), so I will
> > try to send just minor fixes like this.
>
> :)
>
> Again, any thoughts on cache aliasing ?
>

If you have seen something wrong, please tell. What are you thinking about?

Thanks,
     Miguel Ojeda
