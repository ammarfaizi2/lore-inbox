Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269012AbUIXTj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269012AbUIXTj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIXTj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:39:27 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:54157 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S269012AbUIXTjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:39:18 -0400
Date: Fri, 24 Sep 2004 12:39:01 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Lennert Buytenhek <buytenh@wantstofly.org>
cc: Leonid Grossman <leonid.grossman@s2io.com>,
       "'David S. Miller'" <davem@davemloft.net>,
       "'Jeff Garzik'" <jgarzik@pobox.com>, alan@lxorguk.ukuu.org.uk,
       paul@clubi.ie, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
In-Reply-To: <20040924180915.GB26922@xi.wantstofly.org>
Message-ID: <Pine.LNX.4.61.0409241119350.30262@twin.uoregon.edu>
References: <20040924130738.GB24093@xi.wantstofly.org>
 <200409241321.i8ODLf39012346@guinness.s2io.com> <20040924180915.GB26922@xi.wantstofly.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Lennert Buytenhek wrote:

>
>> I was referring to the server side.
>> One can certanly build a 10GbE box based on IPX2800 (or some other parts),
>> but at 17-25W it is not usable in NICs since the entire PCI card budget is
>> less than that - nothing left for 10GbE PHY, memory, etc.

I have a graphics card which requires two four pin molex power connectors, 
going back in time there have allway been certain perphiral cards which 
required external (non-bus supplied power sources for whatever reason) 
(hard-drive on a card, sparc on a card, pc on a card, early 90's hardware 
mpeg encoder, data collection device, remote mangement card, graphics card 
in modern mac etc), it's obviously not a general solution, but it's been 
done frequently enough that it shouldn't just be discarded out of hand.

> Ah, ok, that makes sense.  As someone else also noted, the IXP2800
> only has a 64/66 PCI interface anyway, so it wouldn't really be
> suitable for the task you were referring to.
>
>
> cheers,
> Lennert
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

