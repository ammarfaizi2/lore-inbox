Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287612AbSAFH5l>; Sun, 6 Jan 2002 02:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSAFH5b>; Sun, 6 Jan 2002 02:57:31 -0500
Received: from unknown-1-11.wrs.com ([147.11.1.11]:27865 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id <S287612AbSAFH5S>;
	Sun, 6 Jan 2002 02:57:18 -0500
From: mike stump <mrs@windriver.com>
Date: Sat, 5 Jan 2002 23:56:23 -0800 (PST)
Message-Id: <200201060756.XAA27314@kankakee.wrs.com>
To: dewar@gnat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Paul Mackerras <paulus@samba.org>
> Date: Sun, 6 Jan 2002 16:32:05 +1100 (EST)

> * I need a way to tell the compiler not to make any assumptions about
>   what objects that such a pointer might or might not point to, so
>   that the effect of dereferencing the pointer is simply to access the
>   memory at the address I gave, and is not considered "undefined"
>   regardless of how I might have constructed the address.

> GCC already does the first and third, but there doesn't seem to be a
> clean and reliable way to do the second.

I gave such a snippet of code in my previous posting.  Please show me
when it doesn't work.  I am unaware.
