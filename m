Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWHGTdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWHGTdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWHGTdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:33:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:53711 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932218AbWHGTdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:33:04 -0400
Message-ID: <44D7955D.9000601@zytor.com>
Date: Mon, 07 Aug 2006 12:32:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Mike Galbraith <efault@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc4
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org> <1154963282.4910.13.camel@Homer.simpson.net> <44D77913.2030602@zytor.com> <Pine.LNX.4.61.0608071951470.3365@yvahk01.tjqt.qr> <44D77F72.9040503@zytor.com> <20060807191430.GA13639@kroah.com>
In-Reply-To: <20060807191430.GA13639@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Aug 07, 2006 at 10:59:14AM -0700, H. Peter Anvin wrote:
>> Jan Engelhardt wrote:
>>>>>> It's been a week since -rc3, so now we have a -rc4.
>>>>> Hm.  It still hasn't arrived on kernel.org...
>>>> Looks like Linus never uploaded it...
>>>>
>>> Not even the incr/patch-2.6.18-rc3-rc4 one...
>> That one is auto-generated.
> 
> Oops, I created it myself and added it to the tree.  Wonder if the
> auto-generator will overwrite it...
> 
> Hope I didn't break anything.
> 

It won't overwrite it; it'll probably be fine the way it is.

	-hpa
