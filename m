Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129262AbQJ0QUI>; Fri, 27 Oct 2000 12:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbQJ0QT6>; Fri, 27 Oct 2000 12:19:58 -0400
Received: from harrier.prod.itd.earthlink.net ([207.217.121.12]:10178 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129262AbQJ0QTt>; Fri, 27 Oct 2000 12:19:49 -0400
Message-ID: <044a01c04031$b146db80$0a25a8c0@wizardess.wiz>
From: "J. Dow" <jdow@earthlink.net>
To: <dave@kd0yu.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200010271316.e9RDGSR17634@goliath.kd0yu.com>
Subject: Re: Off-Topic (or maybe on-topic)
Date: Fri, 27 Oct 2000 09:19:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <dave@kd0yu.com>

> If Bill said 'screw you' to the blackmailer and made the press release,
> we should see the source on web sites soon.  Then we can see how bad it
> really is.  Maybe even fix it.

Dave, my partner has legal access to the MS source code. In some of my own
work I discovered an interesting apparent HAL bug related to the ACPI and
the PerformanceCounter API. A fix for a bad INTEL chip (24 bit counter that
doesn't always count correctly) was falsed by my K7M motherboard with a
700MHz Athlon on it. He adapts the HALs for some behemoth machines. So he
has seen the code involved. It is literally chock full of hacks and patches
and such - because of chip hardware defects. I'd be VERY careful about
casually going in and patching or repairing that source code based on such
dinnertable conversation about the HAL code as we've had. (I know no details.
I just know he regularly moans about it. - I bet he's having an interesting
day up there today. He's there for a meeting with the W2K folks. I'll have
to ask him how the anthill was today when he gets home.)

{^_-}    Joanne Dow, jdow@earthlink.net, jdow@bix.com, sysmgr@bix.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
