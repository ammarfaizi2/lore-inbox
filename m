Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265307AbSJRSv4>; Fri, 18 Oct 2002 14:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSJRSvg>; Fri, 18 Oct 2002 14:51:36 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:32760 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id <S265307AbSJRStK>; Fri, 18 Oct 2002 14:49:10 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Arnaud Gomes-do-Vale'" <arnaud@glou.org>,
       "'Thomas Molina'" <tmolina@cox.net>
Cc: <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse
Date: Fri, 18 Oct 2002 11:54:57 -0700
Organization: Murgatroid.Com
Message-ID: <004601c276d7$dc0bc400$8100000a@bergamot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <m365vz7fok.fsf@carrosse.in.glou.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI.  I have always had X configured for ImPS/2.  My wheel problem came
about immediately after booting a 2.5 kernel and using the input layer.
Before I was running a 2.4 kernel with psaux -- X was handling the mouse
protocol.

-ch

-----Original Message-----
From: arnaud@carrosse.glou.org [mailto:arnaud@carrosse.glou.org] On
Behalf Of Arnaud Gomes-do-Vale
Sent: Friday, October 18, 2002 11:42 AM
To: Thomas Molina
Cc: Christopher Hoover; vojtech@suse.cz
Subject: Re: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse


Thomas Molina <tmolina@cox.net> writes:

> I am also carrying a problem report from Arnaud Gomes-do-Vale with
this 
> exact problem.  If this is deemed a proper fix it would probably close

> the other outstanding report.

Oops, I didn't acknowledge Vojtech's fix (that is, configure X for an
ImPS/2 mouse, not MouseManPlusPS/2). This works for me at least.

-- 
Amicalement,
Arnaud

