Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWCWQLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWCWQLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWCWQLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:11:14 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:19955 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932159AbWCWQLN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:11:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xkmrwue5CdEsRlSkWZpPVblKXkzq7p9Ba3jzEX7RR+5haNONnE98im+68UVHxKVuk4n6R6uSKTnCaPPpjGZLjuFs/FiyUTpwLMec/2bAb5bBIWBI5wcDnZH0Y0KdQmGIynQxxkYmda8OyUSkJRoGrz6LxZzabQn2qmKArflpMpA=
Message-ID: <6bffcb0e0603230811w4b7d03fex@mail.gmail.com>
Date: Thu, 23 Mar 2006 17:11:12 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Roman Zippel" <zippel@linux-m68k.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: 2.6.16-mm1
In-Reply-To: <20060323144922.GA25849@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	 <6bffcb0e0603230631r5e6cc3d3p@mail.gmail.com>
	 <20060323144922.GA25849@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On 23/03/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> CONFIG_SERIAL_8250=m
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_PNP=y
>
> That's an illegal configuration.
>
[snip]
>
> So it would seem to be a Kconfig bug.

Thanks for explanation of the problem

Everything is ok, when I state CONFIG_SERIAL_8250=y in kernel config.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
