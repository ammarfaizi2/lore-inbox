Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRFRHrT>; Mon, 18 Jun 2001 03:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbRFRHrJ>; Mon, 18 Jun 2001 03:47:09 -0400
Received: from [62.172.234.2] ([62.172.234.2]:27206 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S263748AbRFRHq5>;
	Mon, 18 Jun 2001 03:46:57 -0400
Date: Mon, 18 Jun 2001 08:47:57 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: function of getname() function
In-Reply-To: <Pine.LNX.4.10.10106181324110.11158-100000@blrmail>
Message-ID: <Pine.LNX.4.21.0106180846290.606-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathish,

The function of getname() is to allocate some (kernel-space) memory for
the userspace-passed filename and copy it from user space to kernel space.

Regards,
Tigran

On Mon, 18 Jun 2001, SATHISH.J wrote:

> Hi,
> 
> Sorry if this question is too silly.
> 
> I could not understand what getname(filename) function in the sys_open()
> function is doing. I could not understand from the code what exactly it is
> doing. Please help me with the same.
> 
> Thanks in advance,
> 
> Regards,
> sathish
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

