Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWBNGON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWBNGON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbWBNGON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:14:13 -0500
Received: from math.ut.ee ([193.40.36.2]:35026 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1030482AbWBNGOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:14:12 -0500
Date: Tue, 14 Feb 2006 08:13:55 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: dtor_core@ameritech.net
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: psmouse starts losing sync in 2.6.16-rc2
In-Reply-To: <d120d5000602130913t2e7a00a6ic86b7c81c0c10b9c@mail.gmail.com>
Message-ID: <Pine.SOC.4.61.0602140813150.20587@math.ut.ee>
References: <Pine.SOC.4.61.0602051443460.17326@math.ut.ee>
 <d120d5000602130913t2e7a00a6ic86b7c81c0c10b9c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> psmouse.c: resync failed, issuing reconnect request
>> input: ImExPS/2 Generic Explorer Mouse as /class/input/input3
>> psmouse.c: resync failed, issuing reconnect request
>> input: ImExPS/2 Generic Explorer Mouse as /class/input/input4
>> psmouse.c: resync failed, issuing reconnect request
>> input: ImExPS/2 Generic Explorer Mouse as /class/input/input5
>>
>
> Does this happen every time you leave mouse idle fore more than 5 sec?

No, it has happened total about 9 times by now.

-- 
Meelis Roos (mroos@linux.ee)
