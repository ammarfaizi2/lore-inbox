Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268353AbUHXV6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268353AbUHXV6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267450AbUHXV6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:58:24 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:36196 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S268356AbUHXVyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:54:17 -0400
Message-ID: <412BB8FF.3090601@travellingkiwi.com>
Date: Tue, 24 Aug 2004 22:54:07 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexander Rauth <Alexander.Rauth@promotion-ie.de>,
       linux-kernel@vger.kernel.org
Subject: Re: radeonfb problems (console blanking & acpi suspend)
References: <1093277876.9973.15.camel@pro30.local.promotion-ie.de> <20040824110024.GA3502@openzaurus.ucw.cz>
In-Reply-To: <20040824110024.GA3502@openzaurus.ucw.cz>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>2) after an acpi suspend the backlight goes back on but there is no data
>>displayed on the screen (no X running nor started since boot)
>>
>>If more information is needed for diagnosis then please email me.
>>    
>>
>
>Known problem for suspend-to-ram, see Ole Rohne's patches.
>  
>
Really? I use 2.6.8.1 on an r50p with radeonfb enabled, and don't 
experience this... But I do run X as well (X.Org) with the X.Org radeon 
driver

I do have problems with a total freeze several minutes after the SECOND 
suspend... But I'm stil trying to track that down...

H
