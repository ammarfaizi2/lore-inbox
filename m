Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319224AbSHUWMI>; Wed, 21 Aug 2002 18:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319226AbSHUWMI>; Wed, 21 Aug 2002 18:12:08 -0400
Received: from tufnell.london1.poggs.net ([193.109.194.18]:7659 "EHLO
	tufnell.london1.poggs.net") by vger.kernel.org with ESMTP
	id <S319224AbSHUWMI>; Wed, 21 Aug 2002 18:12:08 -0400
Message-ID: <3D641156.9000209@POGGS.CO.UK>
Date: Wed, 21 Aug 2002 23:16:54 +0100
From: Peter Hicks <Peter.Hicks@POGGS.CO.UK>
Organization: Poggs Computer Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-gb, en-us, en-au, en-ie, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on EFS bug
References: <Pine.LNX.4.44.0208212031530.21363-100000@tufnell.london1.poggs.net> <1029960251.26411.175.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>The problem isn't the freshly burnt CD, as I tried with the original SGI CD,
>>which shows the same problem using ide-scsi, but is fine when I access things
>>natively over IDE.
>>    
>>
>
>That confirms my suspicion. Patch below. The bug cases should now error
>politely
>
>  
>
Just to confirm the patch works like a treat.  Thank you very much for 
your help!

Best wishes,


Peter.

