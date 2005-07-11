Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVGKR4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVGKR4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVGKRyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:54:13 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:33450 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262141AbVGKRwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:52:50 -0400
Date: Mon, 11 Jul 2005 10:52:49 -0700
From: Tom Duffy <Tom.Duffy@Sun.COM>
Subject: Re: [openib-general] Re: [PATCH 3/27] Add MAD helper functions
In-reply-to: <200507111839.41807.adobriyan@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Hal Rosenstock <halr@voltaire.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Message-id: <42D2B1F1.7000408@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <1121089079.4389.4511.camel@hal.voltaire.com>
 <200507111839.41807.adobriyan@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>unsigned int __nocast gfp_mask, please. 430 or so infiniband sparse warnings
>is not a reason to add more.
>  
>
Can you please elaborate on the sparse warnings that you are seeing 
throughout the rest of infiniband?

Thanks,

-tduffy
