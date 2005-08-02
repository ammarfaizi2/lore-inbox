Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVHBWGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVHBWGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 18:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVHBWGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 18:06:30 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:59693 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261810AbVHBWG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 18:06:29 -0400
Message-ID: <42EFEE64.6040103@blueyonder.co.uk>
Date: Tue, 02 Aug 2005 23:06:28 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Touchpad errors
References: <42EF633B.6080209@blueyonder.co.uk> <d120d500050802072256a4d7ee@mail.gmail.com>
In-Reply-To: <d120d500050802072256a4d7ee@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2005 22:07:14.0155 (UTC) FILETIME=[89C6FBB0:01C597AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 8/2/05, Sid Boyce <sboyce@blueyonder.co.uk> wrote:
> 
>>New SuSE 9.3 x86_64 install after HD crash. With 2.6.13-rc3 and up to
>>2.6.13-rc4-git4. I can't remember seeing these errors for quite a long
>>time, thought they were fixed, perhaps there is a regression in recent
>>kernels.
>>It completely and rapidly fills up dmesg and /var/log/messages so I
>>can't get other stuff I need to see.
>>psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
>>psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
>>
> 
> 
> Does it work with acpi=off?
> 
It does not boot with SuSE 9.3 default kernel, 2.6.13-rc3 or 
2.6.13-rc4-git4, locks up after an initial message with a blank screen.
Acer 1501LCe x86_64 laptop.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
