Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbUCZPW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUCZPW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:22:27 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:28120 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264055AbUCZPWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:22:17 -0500
Message-Id: <200403261522.i2QFMGW28125@dns1.watkins-home.com>
From: "Guy" <bugzilla@watkins-home.com>
To: "'Stefan Smietanowski'" <stesmi@stesmi.com>, "'Eduard Bloch'" <edi@gmx.de>
Cc: "'David Schwartz'" <davids@webmaster.com>, <debian-devel@lists.debian.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: RE: Binary-only firmware covered by the GPL?
Date: Fri, 26 Mar 2004 10:22:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQTRDyu9LxSlWarRN+YWnkAmxixcQAAZCbQ
In-Reply-To: <40644629.9090602@stesmi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please find a GPL list and continue this topic there.

Thanks.

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Stefan Smietanowski
Sent: Friday, March 26, 2004 10:03 AM
To: Eduard Bloch
Cc: David Schwartz; debian-devel@lists.debian.org;
linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?

Hi.

>>>The GPL does not talk about the code to create things, but code to
>>>_modify_ things. If you never have to modify the firmware file, where is
>>>the point?
>>
>>And if I feel like I _want_ to modify it? Then I should be entitled
>>to the preferred form to make modifications to it as is my right
>>under the GPL, regardless of if I a) want to b) have a need to
>>c) give a rat's ass about what the firmware does or does not do.
>>A binary blob is extremely seldom the preferred form to make
>>modifications to, even though some such cases do or might exist.
> 
> Same with WAV and PNG files distributed with many GPL packages. It is
> widely accepted method to distribute files that do not need modification
> without their "source" (whatever source is used to create them).

A WAV file can altered easily using any sound program that will in fact
produce an output that would "work" as would the same apply to a PNG
file. If the result would be pretty or not is a different question
of course :)

To draw a parallel between a WAV or PNG file (a well-known standard)
to a firmware for a specific card (a closed standard) is thin.

Even though I can modify a PNG or WAV file using a hex editor it
is _NOT_ preferred form, and neither is modifying the firmware
using a hex editor, neither to me nor to the people doing the cards.

>>You do know that certain TV cards (using the ivtv driver) lack a rom
>>and needs a firmware initialized during startup just like this example.
>>
>>Why am I taking this up ? Well they have specifically stated that the
>>firmware _may not be used without the windows driver_ even though
>>others have written a fully working driver that _only_ needs the
>>firmware from the windows driver to function under linux.
> 
> Write a firmware loader that extracts it from the Windows DLLs. Such
> things happened in the past and work AFAIK quite good.

Yes, but the legality of it is questionable.

>>Surprised? If they put the firmware on the card (rom/flash/eeprom)
> 
> No.
> 
>>this wouldn't have happened but it did.
>>How exactly do you believe this makes anything more flexible for me
>>as an end user when it is not LEGAL for me to use the card with
>>linux due to the firmware issue.
> 
> Imagine, there is a bug in the firmware. Normaly, you would have to boot
> windows or DOS to run a flash tool to install it into the device. Here
> you just replace the DLL.

You mean get a new DLL and decompile it or otherwise gain access
to said firmware.

>>Yes, some claim there IS a loophole in that the end user MAY extract
>>the firmware from the windows driver himself and use it together
>>with the (open) linux driver but IANAL. Ie use but not redistribute.
> 
> The user gets the driver CD when he buys the hardware.

Some countries might call it illegal to use the contents to other
uses than  issued but a country like germany for instance would
I believe invalidate the license since it was not accepted before
purchase, so the whole thing is very iffy. Again, IANAL.

// Stefan
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


