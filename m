Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTIYLhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTIYLhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:37:31 -0400
Received: from [193.67.22.90] ([193.67.22.90]:37636 "HELO cook.nl")
	by vger.kernel.org with SMTP id S261811AbTIYLh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:37:28 -0400
From: "Ron Verhees" <r.verhees@cook-eu.com>
To: "'Adrian Bunk'" <bunk@fs.tum.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PS2 keyboard & mice mandatory again ?
Date: Thu, 25 Sep 2003 13:36:04 +0200
Message-ID: <007e01c38359$3434f640$c9001f0a@cookvpn.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20030925111547.GL15696@fs.tum.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Personally I never got the point for including something that you won't
need anyway. True you can say that it doesn't hurt anyone on the
computers nowadays but is there any specific reason for not having it
mandatory (eg. Fixing it)?

Regards,
Ron

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Adrian Bunk
Sent: Thursday, September 25, 2003 1:16 PM
To: Nicolas Mailhot
Cc: Vojtech Pavlik; linux-kernel@vger.kernel.org
Subject: Re: PS2 keyboard & mice mandatory again ?

On Thu, Sep 25, 2003 at 10:11:45AM +0200, Nicolas Mailhot wrote:
> 
> Great, now a standard mass-market computer is an embedded device. I
can
> (and will) certainly do it, but this looks like a ticking bomb to me.
>...

What does it cost if an unneeded driver is included in your kernel? 
Perhaps a few kB?

On a standard mass-market computer with 256 MB of RAM where the user 
uses Mozilla under KDE this is quite irrelevant.

EMBEDDED is for people that really have to count every kB to put a 
kernel onto a small floppy/flash/computer with limited RAM.

> Regards,
> Nicolas Mailhot

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

