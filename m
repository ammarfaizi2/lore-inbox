Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTGFRqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTGFRqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:46:49 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:42390 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S262955AbTGFRqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:46:48 -0400
Message-ID: <3F0863EA.9030900@portrix.net>
Date: Sun, 06 Jul 2003 20:01:14 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: yoshfuji@linux-ipv6.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle NULL point when doing lsof
References: <3F0539E5.6030905@portrix.net> <20030704.173441.71640872.yoshfuji@linux-ipv6.org>
In-Reply-To: <20030704.173441.71640872.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki / ???? wrote:
> In article <3F0539E5.6030905@portrix.net> (at Fri, 04 Jul 2003 10:25:09 +0200), Jan Dittmer <j.dittmer@portrix.net> says:
> 
> 
>>Just executing lsof gives a segmentation fault.
>>This is 2.5.73-mm3 and reproducable on dual p3 and single p3-800.
>>Will try 2.5.74-mm1 now.
> 
> 
> Please try http://bugme.osdl.org/attachment.cgi?id=476&action=view
> Thanks.
> 

Yes this fixes it for me on both platforms.

Thanks,

Jan

-- 
Linux rubicon 2.5.74-mm2-jd4 #1 SMP Sun Jul 6 09:55:20 CEST 2003 i686

