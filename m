Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267404AbTACBHY>; Thu, 2 Jan 2003 20:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbTACBHY>; Thu, 2 Jan 2003 20:07:24 -0500
Received: from smtp-101.nerim.net ([62.4.16.101]:26384 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id <S267404AbTACBHW>;
	Thu, 2 Jan 2003 20:07:22 -0500
Message-ID: <3E14E431.4090509@inet6.fr>
Date: Fri, 03 Jan 2003 02:15:29 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
References: <20030102182932.GA27340@linux.kappa.ro>	<1041536269.24901.47.camel@irongate.swansea.linux.org.uk> 	<3E14B698.8030107@inet6.fr> <1041549847.24901.71.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1041549847.24901.71.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Thu, 2003-01-02 at 22:00, Lionel Bouton wrote:
>  
>
>>#2 Are there any other cable-quality hardware tests done by the chipsets 
>>? How ?
>>    
>>
>
>Oh god. Andre described this one as needing a "two beer" explanation.
>I'd recommend stronger drinks however.
>  
>

In that case the thing should be within my body specifications :-)

>>#3 Is the above cable electrically able to sustain 66+ UDMA transfers 
>>(could I hack a driver in order to bypass the 80pin cable detection and 
>>make it work properly) ?
>>    
>>
>
>It is possible to do this yes. Other vendors do it as well. Careful
>cable choice lets you meet the electrical requirements other ways in
>certain situations.
>  
>

Given what I see on sales (various out of spec drives/cables and maybe 
even controllers) I'm suspecting that some of these vendors might use 
plain trial and error cable testing...
This is why I'd prefer to have real electrical specs at hand to make my 
own checks.

LB.

