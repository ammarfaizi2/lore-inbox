Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSKYWus>; Mon, 25 Nov 2002 17:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbSKYWus>; Mon, 25 Nov 2002 17:50:48 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:40184 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S265798AbSKYWur>; Mon, 25 Nov 2002 17:50:47 -0500
Message-ID: <3DE2AB46.70100@mvista.com>
Date: Mon, 25 Nov 2002 15:59:18 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Joao \"Alberto M. dos Reis \" \"(listas de discucao)\"" 
	<lista@vudu.ath.cx>
CC: lista do kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Load Balance
References: <1038264237.3731.9.camel@goku>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joao,

Your looking for bonding driver, which is in the kernel and also has a 
seperate sourceforge project where development works.

Thanks
-steve

Joao Alberto M. dos Reis (listas de discucao) wrote:

>There is any way to make 2 intel ethernet cards working as one, like the
>Network Load Balance (NLB - Windows) in the Intel Ethernet adapters with
>the Adaptive Load Balance feature on linux? 
>
>I know that in windows it works, but in the linux? Anyone has any
>ideias? 
>
>Joao Reis.
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>  
>

