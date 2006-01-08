Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752622AbWAHOOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbWAHOOK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbWAHOOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:14:10 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:707 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1752622AbWAHOOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:14:09 -0500
Message-ID: <43C11E31.8090302@ens-lyon.org>
Date: Sun, 08 Jan 2006 09:14:09 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>	<43C0172E.7040607@ens-lyon.org>	<20060107145800.113d7de5.akpm@osdl.org>	<43C050FA.9040400@ens-lyon.org> <20060108042855.183c35cc.akpm@osdl.org>
In-Reply-To: <20060108042855.183c35cc.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>  
>
>> >> 3) wpa_supplicant does not find my WPA network anymore (while iwlist
>> >> scanning sees). I didn't see anything relevant in dmesg. My driver is
>> >> ipw2200.
>>    
>>
>
>And this one I don't have a clue about.  Can you test the next git
>snapshot, or otherwise work out a bit more about it?
>  
>
I just work out a bit more and finally got it to work... Looks like
wpa_supplicant needs a less flexible configuration now that some of my
neighbors got a wireless access point for christmas. Let's say this bug
does not exist. I'll try to check whether it's really worse on -mm  than
on vanilla.
Sorry about that.

Brice

