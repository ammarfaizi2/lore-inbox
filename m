Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279927AbRLDRe0>; Tue, 4 Dec 2001 12:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281165AbRLDRQC>; Tue, 4 Dec 2001 12:16:02 -0500
Received: from [12.237.132.167] ([12.237.132.167]:61313 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S281077AbRLDRP1>; Tue, 4 Dec 2001 12:15:27 -0500
Message-ID: <3C0D04A5.7090400@attbi.com>
Date: Tue, 04 Dec 2001 11:15:17 -0600
From: Jordan Breeding <ledzep37@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OSS driver cleanups.
In-Reply-To: <E16BJ58-0002hg-00@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Not least because I have reports from my housemate that ALSA drivers are
>>a b*tch to set up.  To be done only if there isn't an OSS driver for
>>your card.  Whereis with OSS you just load a module and its done.
>>
> 
> Thats already a "must fix"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

Once in 2.5.X will the ALSA drivers still be modular only or will they 
be able to be linked statically into the kernel as the current OSS 
drivers are able to be?

