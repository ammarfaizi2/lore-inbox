Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVJYCxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVJYCxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 22:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVJYCxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 22:53:21 -0400
Received: from mail.majordomo.ru ([81.177.16.8]:30981 "EHLO mail.majordomo.ru")
	by vger.kernel.org with ESMTP id S1751419AbVJYCxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 22:53:20 -0400
Message-ID: <435DD708.1080802@lindevel.ru>
Date: Tue, 25 Oct 2005 06:56:08 +0000
From: "Nikolay N. Ivanov" <group@lindevel.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13.4: don't reboot
References: <20051024231235.3C0F81CB1E6@anxur.fi.muni.cz>
In-Reply-To: <20051024231235.3C0F81CB1E6@anxur.fi.muni.cz>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>OK, I sent e-mail that wasn't delivered :(. Maybe the unicode `pishyot' was the
>problem.
>
>So, could you accurate the version where that occurs first time as much as
>possible. I.e. the best is to tell us it is between 2.6.11.5 and 6 or sth.
>
>Then make a diff -u between dmesg -s 1000000 of the 2 versions and attach used
>.config.
>
>thanks,
>  
>
It's mysticism! This error is unpredictable: in 2.6.10 kernel also 
occured but SOMETIMES. The same result on three kernels and on two 
distributives: 2.6.10, 2.6.11 and 2.6.13. I'm in confusion. I also tryed 
to disable all acpi and apm functions but in vain.

With best regards, Nikolay.

P.S. I think that .config and dmesg can't help here.


