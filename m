Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWJDE0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWJDE0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWJDE0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:26:50 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:53648 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932375AbWJDE0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:26:49 -0400
Message-ID: <4523384E.7060806@candelatech.com>
Date: Tue, 03 Oct 2006 21:27:58 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com>	 <m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com>	 <m3hcyo2qvs.fsf@defiant.localdomain>  <45200BD7.6030509@candelatech.com> <1159735586.13029.180.camel@localhost.localdomain>
In-Reply-To: <1159735586.13029.180.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Sul, 2006-10-01 am 11:41 -0700, ysgrifennodd Ben Greear:
>   
>> At least some out-of-tree drivers seem to be able to do this.  For 
>> instance, these guys:
>> http://www.farsite.co.uk/
>>     
>
>
> The crazy Zaptel guys can probably do precisely what you need as their
> hardware though aimed at voice work lets software get in at an extremely
> low level.
>   
I think you might be right.  It will take some more experimenting to see 
if they allow
enough control to read/write bitstreams (clear channel groups in their 
terminology, I believe) while at
the same time keeping the timing slots in order...

Thanks,
Ben

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   


-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


