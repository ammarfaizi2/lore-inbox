Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUDUHit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUDUHit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 03:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUDUHit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 03:38:49 -0400
Received: from mta-ms-be-01.sunrise.ch ([194.158.229.96]:28142 "EHLO
	mail-ms.sunrise.ch") by vger.kernel.org with ESMTP id S263626AbUDUHiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 03:38:46 -0400
Message-ID: <31404467.1082533098090.JavaMail.tomcat4@webmail-be-07.sunrise.ch>
Date: Wed, 21 Apr 2004 09:38:18 +0200 (MEST)
From: ann_pearlstein@mysunrise.ch
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re:Re: libata and the 2.4 kernel
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo and the mailing list,

Thanks for the information.

For anyone else with similar questions, here's a good article on the subject, visit kerneltrap.org - there's an article abou it.  Here's the horrible URL:

http://kerneltrap.org/node/view/2926?PHPSESSID=01eda553525e02042e94270e386a37f6

Cheers,

Ann

Ann Pearlstein
ann_pearlstein@mysunrise.ch


>On Tue, Apr 20, 2004 at 02:21:50PM +0200, ann_pearlstein@mysunrise.ch wrote:
>> Hello,
>> 
>> Does anyone know when (or even if) the libata patch will be native to the 2.4 kernel (e.g., no patch needed)?  
>> 
>> If there are plans to add it to the 2.4 kernel, when (approximately :-)  ) will it be a part of this kernel?
>> 
>> I know it's supported natively in the 2.6 kernel.
>> 
>> The libata patch (2.4.25 kernel and 2.4.25 libata patch) works well for the serial ATA drive I use (in a Dell PowerEdge 750), but I'd like to have a non-patched kernel for this particular project.  
>> 
>> Thank you in advance for any and all info.
>
>Ann, 
>
>libata has been included in the 2.4 BK tree.
>
>You can try 2.4.26-bk patches (www.kernel.org)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
