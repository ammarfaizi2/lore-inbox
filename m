Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVEPNSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVEPNSh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVEPNSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:18:37 -0400
Received: from [80.247.74.3] ([80.247.74.3]:9407 "EHLO tavolara.isolaweb.it")
	by vger.kernel.org with ESMTP id S261609AbVEPNS0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:18:26 -0400
Message-Id: <6.2.1.2.2.20050516151659.077cceb0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Mon, 16 May 2005 15:18:23 +0200
To: Eric Dumazet <dada1@cosmosbay.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: How to use memory over 4GB
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <428898CF.5060908@cosmosbay.com>
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
 <428898CF.5060908@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
X-IsolaWeb-MailScanner-Information: Please contact the ISP for more information
X-IsolaWeb-MailScanner: Found to be clean
X-MailScanner-From: kernel@tekno-soft.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14.57 16/05/2005, Eric Dumazet wrote:

>Roberto Fichera a écrit :
>>Hi All,
>>I've a dual Xeon 3.2GHz HT with 8GB of memory running kernel 2.6.11.
>>I whould like to know the way how to use all the memory in a single
>>process, the application is a big simulation which needs big memory chuncks.
>
>AFAIK the best you can have with a 32bits processor, is 4GB for one process.

Yes! I know ;-)!


>But still you need a 4GB/4GB user/kernel split, because the standard is 
>3GB/1GB.

Why I need 4GB/4GB split? What are the beneficts?


>Eric
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

Roberto Fichera. 

