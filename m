Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUAYUeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUAYUeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:34:10 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:15377 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265274AbUAYUeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:34:07 -0500
Message-ID: <4014283D.9040207@blueyonder.co.uk>
Date: Sun, 25 Jan 2004 20:34:05 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040118
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: John Stoffel <stoffel@lucent.com>
Subject: Re: 2.6.2-rc1-mm2 kernel oops
References: <4013D0AA.8060906@blueyonder.co.uk> <16404.8968.349900.566999@gargle.gargle.HOWL>
In-Reply-To: <16404.8968.349900.566999@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2004 20:34:28.0128 (UTC) FILETIME=[A0E76A00:01C3E382]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:
> Sid> Andrew Morton wrote:
> Sid> Sid Boyce <sboyce@xxxxxxxxxxxxxxxx> wrote:
> 
>>>>I get this on bootup, Athlon XP2200+
>>>>=====================================
>>>>Linux version 2.6.2-rc1-mm2 (root@barrabas) (gcc version 3.3.1 (SuSE
>>>>...
>>>>EIP is at test_wp_bit+0x36/0x90
> 
> 
>>>oh crap, why does this thing keep breaking? Please send your .config
>>>over,
>>>thanks.
> 
> 
> Sid> Linus aslso asked if 2.6.2-rc1 work -- I shall build it
> Sid> shortly. I also get the same error with 2.6.2-rc1-mm3.
> 
> It doesn't work for me here, I started with 2.6.2-rc1 and moved up
> through mm1 and mm3, all either hind on boot (after the uncompressing
> message) or crashed with the test_wp_bit Oops that seems to be going
> around.
> 
> 2.6.1-mm4 is the last stable version that works for me.
> 
> John
>    John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
> 	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
> 

See my previous post, I just commented out the line that Adrian Bunk 
asked me to remove and it's now up and running.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.
