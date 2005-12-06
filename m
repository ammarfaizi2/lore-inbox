Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVLFQ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVLFQ12 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVLFQ12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:27:28 -0500
Received: from darla.ti-wmc.nl ([217.114.97.45]:47822 "EHLO smtp.wmc")
	by vger.kernel.org with ESMTP id S932281AbVLFQ11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:27:27 -0500
Message-ID: <4395BBDB.307@ti-wmc.nl>
Date: Tue, 06 Dec 2005 17:27:07 +0100
From: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	 <200512051826.06703.andrew@walrond.org> <1133807641.9356.50.camel@laptopd505.fenrus.org>
In-Reply-To: <1133807641.9356.50.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2005-12-05 at 18:26 +0000, Andrew Walrond wrote:
> 
>>On Monday 05 December 2005 10:52, Arjan van de Ven wrote:
>>
>>>a hypothetical doomsday scenario by Arjan van de Ven
>>>
>>
>>Can I ask what prompted your post?
> 
> 
> I got one too many hatemails from a "nvidia fanboy" who blamed me for
> just about anything wrong in the world.... I fear that most of these
> people have no idea why open source drivers matter, or at least what the
> consequences are for not caring about drivers being open or not.
> 
> 

I suppose this is as good as any point in the thread to add my 2 
eurocents...

I use nvidia cards, mostly because they work better than an alternative 
for now, but every time I need a card I look for stuff that is more 
open, because I hate to have to use the non-free closed stuff to do 
graphics. (Having no real choice in this is really annoying to me!)

I believe the kernel community has a great leverage point on these 
proprietary vendors (although I don't know how far this goes), by 
changing the ABI/API fairly often, they will have to adjust their driver 
building tools as well. This will become annoying to them and may cause 
them to free some more parts of their code. This is not a full solution, 
but at least it will cause them to rethink their policies more often.

Alternatively, I'd be willing to pay some more money than for an 
equivalent closed source driver card, to get good hardware with a GPL 
driver. I may not be part of the majority of PC equipment buyers though ;-)

Cheers

Simon
