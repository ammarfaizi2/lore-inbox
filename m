Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283657AbRK3NV3>; Fri, 30 Nov 2001 08:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283652AbRK3NVJ>; Fri, 30 Nov 2001 08:21:09 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:5651 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S283651AbRK3NVD>; Fri, 30 Nov 2001 08:21:03 -0500
Message-ID: <3C07878E.2@namesys.com>
Date: Fri, 30 Nov 2001 16:20:14 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: jose@iteso.mx, linux-kernel@vger.kernel.org
Subject: Re: 32 bit UIDs on 2.4.14
In-Reply-To: <E169lOX-00035g-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>  What is the trick to get more than 2^16 uids working on all services?=
>>?
>>
>
>2.4.x kernel
>Glibc 2.2
>Up to date pam modules
>ext2/ext3 file system
>
>patches needed for quotas
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>

reiserfs also works, for 32 bit uids

Hans

