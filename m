Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVHBMMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVHBMMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVHBMMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:12:47 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:64730 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261412AbVHBMMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:12:46 -0400
Message-ID: <42EF633B.6080209@blueyonder.co.uk>
Date: Tue, 02 Aug 2005 13:12:43 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Touchpad errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2005 12:13:27.0515 (UTC) FILETIME=[96A522B0:01C5975B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New SuSE 9.3 x86_64 install after HD crash. With 2.6.13-rc3 and up to 
2.6.13-rc4-git4. I can't remember seeing these errors for quite a long 
time, thought they were fixed, perhaps there is a regression in recent 
kernels.
It completely and rapidly fills up dmesg and /var/log/messages so I 
can't get other stuff I need to see.
psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
