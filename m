Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275043AbRJJHiR>; Wed, 10 Oct 2001 03:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275045AbRJJHiH>; Wed, 10 Oct 2001 03:38:07 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:55729 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S275043AbRJJHhy>; Wed, 10 Oct 2001 03:37:54 -0400
Message-ID: <3BC3FB00.3050100@wipro.com>
Date: Wed, 10 Oct 2001 13:08:40 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kirill Ratkin <kratkin@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kdb requires kallsyms
In-Reply-To: <20011010071413.53845.qmail@web11905.mail.yahoo.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kirill Ratkin wrote:

>Hi. 
>
>I've trouble with kdb. I've patched my kernel (stable
>2.4.10) and tried to make kernel with kdb (from SGI)
>and I see :
>/bin/sh: /sbin/kallsyms: No such file or directory
>make[1]: *** [kallsyms] error 127
>
>Where can I find this kallsyms?
>
modutils provides this executable. please use
rpm -q --whatprovides `type <name of file>' to see which package provides
the executable.

Regards,
Balbir

>
>Regards,
>
>
>
>
>
>__________________________________________________
>Do You Yahoo!?
>Make a great connection at Yahoo! Personals.
>http://personals.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
