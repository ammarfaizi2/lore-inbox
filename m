Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264326AbUENHwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbUENHwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUENHwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 03:52:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:30626 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264355AbUENHwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 03:52:37 -0400
X-Authenticated: #4512188
Message-ID: <40A47AC3.4010403@gmx.de>
Date: Fri, 14 May 2004 09:52:35 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040504)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2, usb ehci warnings/error?
References: <40A3962F.3020500@pacbell.net>
In-Reply-To: <40A3962F.3020500@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
>> There appear lines like
>>
>> usb usb2: string descriptor 0 read error: -108
>>
>> bug or feature? They weren't there with 2.6.6-mm1. I have no usb2.0 
>> stuff to actually test. My usb1 stuff seems to work though.
> 
> 
> Bug; minor, since the only real symptom seems to be messages like
> that.  Ignore them for now, I'll make a patch soonish.


Ok, good. Thanks for the explanation of what is going on, though I don't 
can make too much out of it. ;-)

Prakash
