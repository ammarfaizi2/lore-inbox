Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTBKRfI>; Tue, 11 Feb 2003 12:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbTBKRfI>; Tue, 11 Feb 2003 12:35:08 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:15663 "EHLO
	valis.localnet") by vger.kernel.org with ESMTP id <S264956AbTBKRfH>;
	Tue, 11 Feb 2003 12:35:07 -0500
Message-ID: <3E49366E.10508@murphy.dk>
Date: Tue, 11 Feb 2003 18:44:14 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtdblock read only device broken?
References: <3E48080F.9060209@murphy.dk> <1044978975.2263.28.camel@passion.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>On Mon, 2003-02-10 at 20:14, Brian Murphy wrote:
>  
>
>>Is the mtd read only block device broken in general or is it only for 
>>mips that it doesn't work?
>>    
>>
>
>It was broken during the block device overhaul and nobody bothered to
>fix it up. I've now merged my latest code to Marcelo and most of the
>changes from Linus' tree back into my own -- I should get round to the
>next step of actually sending it to Linus some time in the next few
>weeks. 
>
>  
>
Thanks, can I download and test it from somewhere?

/Brian


