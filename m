Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314497AbSD1UtH>; Sun, 28 Apr 2002 16:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314498AbSD1UtH>; Sun, 28 Apr 2002 16:49:07 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:34244 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S314497AbSD1UtG>;
	Sun, 28 Apr 2002 16:49:06 -0400
Message-ID: <3CCC6036.1080500@acm.org>
Date: Sun, 28 Apr 2002 15:48:54 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} SMBIOS support
In-Reply-To: <E171U1r-0008Pk-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>The following patch adds support for reading the SMBIOS table (which 
>>contains system management information).  It's required for IPMI and has 
>>useful information in it.  But anyway, since I did the work, I thought I 
>>would post this.
>>
>
>We already have DMI table parsing code in 2.4 and 2.5. Its been there for
>a very long time.  Please use that instead
>
>
>Alan
>
Ah, now I see.  All the documentation I had referenced SMBIOS and didn't 
say much about DMI, so I searched around everywhere for SMBIOS, not for DMI.

Thanks,

-Corey

