Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVLNIpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVLNIpQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVLNIpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:45:16 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:57997 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932149AbVLNIpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:45:14 -0500
Message-ID: <439FDC78.9070703@aitel.hist.no>
Date: Wed, 14 Dec 2005 09:48:56 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01EE9BB3@otce2k03.adaptec.com> <439E8565.3000900@aitel.hist.no> <200512131202.30743.gene.heskett@verizon.net>
In-Reply-To: <200512131202.30743.gene.heskett@verizon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Tuesday 13 December 2005 03:25, Helge Hafting wrote:
>  
>
>>Salyzyn, Mark wrote:
>>    
>>
>>>For instance, there are reasons, somewhat outside the control of the
>>>Hardware Vendor, for binary drivers. Often, in the hopes of
>>>achieving standards compliance, Hardware vendors are cornered by
>>>legalities over the copyright associated with those standards that
>>>ties their hands either from releasing interface documentation or
>>>from releasing source code. Yet all these vendors would be
>>>overjoyed to have Linux drivers for their Hardware in order to
>>>increase the sales of their products.
>>>      
>>>
>>Uh, a copyrighted standard?  They are trying to live up to a secret
>>standard, one they cannot publish?
>>Don't sound like a standard to me - a standard is something known,
>>that is the purpose of standardization.
>>This sounds like "we standardized the voltage for household lamps,
>>but we won't tell if it is 110V, 220V or something completely
>>different." I really hope I misunderstood this.
>>    
>>
>
>Standards bodies typically get their supporting income from the sale of 
>the standard specification in fancy printed pdf's.  As its a small 
>market, the only way to survive is the highway robbery model where a 
>copy is maybe over $1000 USD.  Its a bad model for the FOSS crowd as 
>they may not have the bucks to spend on a real copy.  Generally, their 
>copyrights are VERY well enforced by their shysters which compounds 
>the issue.
>  
>
This is not a problem.  We ask for GPL source code, not
the fancy printed copyrighted pdf.  Sure it'd be nice to have,
maintenance is harder without it, but the driver itself
should not cause copright problems with a standards
document. This because a copy of the document isn't
included in the driver source. 

>All of our preaching is to the choir, as the standards bodies could 
>care less, if you want a copy, pony up.  Thats life, unforch.
>  
>
Sure - if I want the standard document. No need if all I want is the
driver that was written with the aid of said standard document,
assuming the driver writer didn't include large passages from
the document in the comments.

Something like:
/* Implementation of the xyz algorithm, see std.document for
    specification on how it is supposed to work. */
ought to be fine.

Helge Hafting
