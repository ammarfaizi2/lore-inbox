Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVLNI4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVLNI4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVLNI4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:56:07 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:61069 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932173AbVLNI4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:56:05 -0500
Message-ID: <439FDF03.50504@aitel.hist.no>
Date: Wed, 14 Dec 2005 09:59:47 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Andrea Arcangeli <andrea@cpushare.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01EE9BB3@otce2k03.adaptec.com>	 <439E8565.3000900@aitel.hist.no> <1134467098.30759.8.camel@tara.firmix.at>
In-Reply-To: <1134467098.30759.8.camel@tara.firmix.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:

>On Tue, 2005-12-13 at 09:25 +0100, Helge Hafting wrote:
>  
>
>>Salyzyn, Mark wrote:
>>    
>>
>[...]
>  
>
>>>For instance, there are reasons, somewhat outside the control of the
>>>Hardware Vendor, for binary drivers. Often, in the hopes of achieving
>>>      
>>>
>
>Even if this is the case it is the decision of the hardware vendor to go
>that way. The underlying organzation may be equally guilty but that
>doens't make the hardware vendor innocent - simply he plays the same
>game just with an excuse.
>
>  
>
>>>standards compliance, Hardware vendors are cornered by legalities over
>>>the copyright associated with those standards that ties their hands
>>>either from releasing interface documentation or from releasing source
>>>code. Yet all these vendors would be overjoyed to have Linux drivers for
>>>their Hardware in order to increase the sales of their products.
>>>      
>>>
>
>Then it is up to them to do something.
>
>  
>
>>Uh, a copyrighted standard?  They are trying to live up to a secret
>>standard, one they cannot publish?
>>Don't sound like a standard to me - a standard is something known,
>>that is the purpose of standardization.
>>This sounds like "we standardized the voltage for household lamps, but
>>we won't tell if it is 110V, 220V or something completely different."
>>I really hope I misunderstood this.
>>    
>>
>
>s/copyright/patent/ then you will get it probably more right.
>Given (beautiful and readable) source code, a patent infringement is
>probably much easier to proove than with disassembled output of gcc-4.x.
>  
>
Oh.  So they are infringing already, and just trying to hide it?
This is so common that it applies to most drivers? :-(

>  
>
>>Standards compliance should never get in the way of open source.
>>Sure - if the owner modifies the source, then the thing may no longer
>>comply with the standard.  In some cases even illegal or dangerous. 
>>    
>>
>
>Propriatory vendors (the larger they are, the more it makes sense) do
>that all the time without telling their customers/users (usually
>somewhere hidden within some tools which produce not compliant garbage)
>and the strategy is called "customer lockin".
>  
>
Closed source may lock customers out, not in.  I don't see how an
open source driver makes it easier for the customer to get away
from the product.  If the proprietary nvidia driver went open source,
it still wouldn't work with competing cards - the hw is too different.
Copying the _hardware_ is still a copyright infringement, and possibly
also a patent issue.

>  
>
>>But in that case, it is the fault of the owner, not the vendor. The vendor
>>can simply say that anyone changing the (distributed) source should get
>>their own certification.
>>    
>>
>
>At least for (certified) ISDN stacks any change on the source (including
>trivial bug fixes) invalidates any official certification AFAIK.
>  
>
And that does not in any way prevent open source.  Sure - if you
_change_ that source you invalidate certification, but that is
your problem, not the vendors problem.  It is not a reason to
keep the code secret.  If anything goes wrong, they can simply
point the finger, the vendor driver is ok.

Helge Hafting
