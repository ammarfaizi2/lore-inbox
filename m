Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRL1Vj6>; Fri, 28 Dec 2001 16:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRL1Vjt>; Fri, 28 Dec 2001 16:39:49 -0500
Received: from mout1.freenet.de ([194.97.50.132]:50393 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S278522AbRL1Vjj>;
	Fri, 28 Dec 2001 16:39:39 -0500
Message-ID: <3C2CE6F9.5090209@athlon.maya.org>
Date: Fri, 28 Dec 2001 22:41:13 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: Troels Walsted Hansen <troels@thule.no>
CC: "'Kernel-Mailingliste'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre1
In-Reply-To: <000e01c18fe4$1b0f7d80$0300000a@samurai>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troels Walsted Hansen wrote:

>>>- Update Athlon/VIA PCI quirks			(Calin A.
>>>
>>I tested this patch and unfortunately, I have to say, it is not working
>>
> (if it should prevent the 
> 
>>suddenly changing time on VIA-boards). I have the same problem with
>>
> suddenly changing time as 
> 
>>without this patch.
>>
> 
> Nope, the change is related to a bug in the VIA Northbridge memory write
> queue timer causing oopses on Athlon optimised linux kernels.

Sorry - I thought there could be a dependence between both problems.

Thank you for your hint!


Regards,
Andreas Hartmann

