Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbVJYGxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbVJYGxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 02:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVJYGxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 02:53:19 -0400
Received: from mail.majordomo.ru ([81.177.16.8]:23814 "EHLO mail.majordomo.ru")
	by vger.kernel.org with ESMTP id S1751465AbVJYGxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 02:53:18 -0400
Message-ID: <435E0F44.5020008@lindevel.ru>
Date: Tue, 25 Oct 2005 10:56:04 +0000
From: "Nikolay N. Ivanov" <group@lindevel.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13.4: don't reboot
References: <20051024231235.3C0F81CB1E6@anxur.fi.muni.cz> <435DD708.1080802@lindevel.ru>
In-Reply-To: <435DD708.1080802@lindevel.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> OK, I sent e-mail that wasn't delivered :(. Maybe the unicode 
>> `pishyot' was the
>> problem.
>>
>> So, could you accurate the version where that occurs first time as 
>> much as
>> possible. I.e. the best is to tell us it is between 2.6.11.5 and 6 or 
>> sth.
>>
>> Then make a diff -u between dmesg -s 1000000 of the 2 versions and 
>> attach used
>> .config.
>>
>> thanks,
>
The problem fixed! It's should be set Pentium Pro (for expample) instead 
Pentium M processor in .config. Excuse me for hurly-burly.

With best regards, Nikolay.
