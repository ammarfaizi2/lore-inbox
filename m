Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUAKRLu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUAKRLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:11:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:50669 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265916AbUAKRLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:11:48 -0500
Date: Sun, 11 Jan 2004 18:13:01 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch). (fwd)
In-Reply-To: <200401111138.49858.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.53.0401111808140.1687@calcula.uni-erlangen.de>
References: <Pine.LNX.4.53.0401111652510.1271@calcula.uni-erlangen.de>
 <200401111138.49858.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Today, Dmitry Torokhov wrote:

>From: Dmitry Torokhov <dtor_core@ameritech.net>
>Date: Sun, 11 Jan 2004 11:38:49 -0500
>To: Gunter Königsmann <gunter.koenigsmann@gmx.de>,
>     Gunter Königsmann <gunter@peterpall.de>
>Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
>     Peter Berg Larsen <pebl@math.ku.dk>
>Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
>    loss (With Patch). (fwd)
>
>On Sunday 11 January 2004 11:27 am, Gunter Königsmann wrote:
>> Strike! Helps.
>>
>> No more warnings, no more bad clicks, and a *real* smooth movement.
>>
>
>Great!
>
>Could you tell us what kind of laptop you have (manufacturer/model)
>so other people would not have such pain as you had with it?
>

Siemens/Fujitsu AMILO M 7400 (But the 7400 was somehow hard to find out).

Strike! Hey... Thanks a lot,


Yours,

	Gunter.


>> Never thought, a touchpad can work *this* well... ;-)
>>
>> Anyway, I still get those 4 lines  on leaving X, but don't know, if it
>> is an error of the kernel, anyway, and doesn't do anything bad exept of
>> warning me:
>>
>> atkbd.c: Unknown key released (translated set 2, code 0x7a on
>> isa0060/serio0). atkbd.c: Unknown key released (translated set 2, code
>> 0x7a on isa0060/serio0). atkbd.c: Unknown key released (translated set
>> 2, code 0x7a on isa0060/serio0). atkbd.c: Unknown key released
>> (translated set 2, code 0x7a on isa0060/serio0).
>
>I believe Vojtech said that it's because X on startup tries to talk to the
>keyboard controller directly, nothing to worry about... But I might be
>mistaken.
>
>>
>>
>> Yours,
>>
>> 	Gunter.
>
>Dmitry
>

-- 
[He] took me into his library and showed me his books, of which he had
a complete set.
                -- Ring Lardner
