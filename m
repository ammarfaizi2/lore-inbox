Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVGNFfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVGNFfH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 01:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVGNFfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 01:35:07 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:16001
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S262915AbVGNFfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 01:35:02 -0400
Message-ID: <42D5F934.6000603@prodmail.net>
Date: Thu, 14 Jul 2005 11:03:40 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thread_Id
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it> <42CB465E.6080104@shaw.ca>
In-Reply-To: <42CB465E.6080104@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> RVK wrote:
>
>> Can anyone suggest me how to get the threadId using 2.6.x kernels.
>> pthread_self() does not work and returns some -ve integer.
>
>
> What do you mean, negative integer? It's not an integer, it's a
> pthread_t, you're not even supposed to look at it..

What is pthread_t inturn defined to ? pthread_self for 2.4.x thread 
libraries return +ve number(as u have a objection me calling it as 
integer :-))

Raghu

>
> -- 
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> .
>

