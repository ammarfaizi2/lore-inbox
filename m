Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUAVKsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUAVKsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:48:33 -0500
Received: from catv-5062a04e.szolcatv.broadband.hu ([80.98.160.78]:61840 "EHLO
	catv-5062a04e.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S266202AbUAVKsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:48:31 -0500
Message-ID: <400FAA7D.1010807@freemail.hu>
Date: Thu, 22 Jan 2004 11:48:29 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.1-mm4/5 dies booting on an Athlon64
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Boszormenyi Zoltan writes:
>  > Hi,
>  > 
>  > mainboard is MSI K8T Neo, Athlon64 3200+.
>  > It does not boot successfully without the "nolapic"
>  > option. "noapic" does not make any difference, "nolapic" does.
>  > Kernel is compiled on a 32bit Fedora,
>  > K7/Athlon and Hammer/Opteron/Athlon64
>  > are selected under CPU support.
> 
> 1. "does not boot successfully" is extremely vague.
>    Please supply a boot log or decoded kernel oops.

Uncompressing kernel... and then nothing. Even the screen is emptied,
cursor blinks in column 0 of line approx. 8, at about 1/3 of the screen.

> 2. Does this also occur with 2.6.1 or 2.6.2-rc1?
>    If so, what was the last standard 2.6 kernel that worked?
> 3. Does 2.4.25-pre6 work?

I will try these. FC1 2.4.22-2149 definitely works.

> 4. Try a minimal .config w/o any non-essential features.
>    (Where non-essential mean anything not needed to boot
>    and get to a login prompt.)

OK.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

