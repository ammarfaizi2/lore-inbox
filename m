Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVIZQpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVIZQpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVIZQpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:45:36 -0400
Received: from [85.21.88.2] ([85.21.88.2]:48825 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932356AbVIZQpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:45:35 -0400
Message-ID: <433825FC.7050603@ru.mvista.com>
Date: Mon, 26 Sep 2005 20:46:52 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: dmitry pervushin <dpervushin@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: SPI
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru> <200509261625.j8QGPQ9K007078@turing-police.cc.vt.edu>
In-Reply-To: <200509261625.j8QGPQ9K007078@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My POV is that those lines should go away.

Best regards,
   Vitaly

Valdis.Kletnieks@vt.edu wrote:

>On Mon, 26 Sep 2005 15:12:14 +0400, dmitry pervushin said:
>  
>
>>Hello guys,
>>
>>I am attaching the next incarnation of SPI core; feel free to comment it.
>>    
>>
>
>  
>
>>+/* The devfs code is contributed by Philipp Matthias Hahn 
>>+   <pmhahn@titan.lahn.de> */
>>    
>>
>
>  
>
>>+/* devfs code corrected to support automatic device addition/deletion
>>+   by Vitaly Wool <vwool@ru.mvista.com> (C) 2004 MontaVista Software, Inc. 
>>+ */
>>    
>>
>
>I'd like to thank Vitaly and Philipp for their work, which was probably useful
>at the time, but I've always wondered - when cleaning up code, should such comments
>be removed too, or left as historical reminders?  The MAINTAINERS file seems
>to get cleaned most of the time, the CREDITS doesn't - which way should
>in-source comments go?
>
>  
>

