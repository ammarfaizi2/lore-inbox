Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVGaMjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVGaMjD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 08:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGaMjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 08:39:03 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:42588 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261734AbVGaMi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 08:38:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Z7z/Do241FU7fe/ZrymxlR9mwhQweDU9Ct94+RI7q2vCqsvUOEH7VcjJgy529Mo3IUfU22ofEqqUlIK5vnRngN5Pv1QbEGO5Sn8whs4qZec56xEQH2PTUnoF5El3QuaGAoiio4v8Eqepqy2FDQCtsZ7fcNnZ4i+8WVA95Z8hyOs=
Message-ID: <42ECE2FE.2090204@gmail.com>
Date: Sun, 31 Jul 2005 14:41:02 +0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050726)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-mm1
References: <20050731020552.72623ad4.akpm@osdl.org> <6f6293f105073103045fd32d61@mail.gmail.com>
In-Reply-To: <6f6293f105073103045fd32d61@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana schrieb:

>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/
>>    
>>
>
>Why was the KERNEL_VERSION(a,b,c) macro removed from
>include/linux/version.h? The removal breaks external drivers like
>NDISWRAPPER or nVidia propietary.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hello Felipe,

I could not regonize a breakage of NVidia (Version 1.0-7667) propietary 
drivers.
They work just perfect.

Greets
       Michael
