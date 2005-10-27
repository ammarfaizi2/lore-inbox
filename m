Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbVJ0W3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbVJ0W3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbVJ0W3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:29:49 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:24209 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S1751609AbVJ0W3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:29:48 -0400
Date: Thu, 27 Oct 2005 15:29:31 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Marcel Holtmann <marcel@holtmann.org>
cc: Dave Jones <davej@redhat.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
In-Reply-To: <1130451421.5416.35.camel@blade>
Message-ID: <Pine.LNX.4.64.0510271528560.25823@twin.uoregon.edu>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> 
 <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>
  <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade>
  <20051027211203.M33358@linuxwireless.org>  <20051027220533.GA18773@redhat.com>
 <1130451071.5416.32.camel@blade>  <20051027221253.GA25932@redhat.com>
 <1130451421.5416.35.camel@blade>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005, Marcel Holtmann wrote:

> Hi Dave,
>
>> >> Some boards at least have a BIOS option to support 'memory hoisting'
>> >> to map the 'lost' memory above the 4G address space.
>> >>
>> >> I suspect a lot of the lower-end (and older) boards however don't have
>> >> this option, as they were not tested with 4GB.
>> >
>> > do you have any information about remapping support of the D945GNT
>> > motherboard from Intel.
>>
>> I've not come across an EM64T with that much RAM, so I've not had
>> reason to go looking.. Sorry.
>
> am I really the first person trying to use that board with 4 GB of RAM
> and an Intel Dual-Core with EM64T :(

maybe the first one to not use it to play half-life 2...

> Regards
>
> Marcel
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

