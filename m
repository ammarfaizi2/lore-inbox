Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276641AbRJKRsr>; Thu, 11 Oct 2001 13:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276628AbRJKRsi>; Thu, 11 Oct 2001 13:48:38 -0400
Received: from eispost12.serverdienst.de ([212.168.16.111]:48906 "EHLO imail")
	by vger.kernel.org with ESMTP id <S276641AbRJKRs1>;
	Thu, 11 Oct 2001 13:48:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: Juan Quintela <quintela@mandrakesoft.com>
Subject: Re: APM on a HP Omnibook XE3
Date: Thu, 11 Oct 2001 19:48:20 +0200
X-Mailer: KMail [version 1.3]
Cc: Chmouel Boudjnah <chmouel@mandrakesoft.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200108301443355.SM00167@there> <200110101943880.SM00161@there> <m2het7jpgg.fsf@anano.mitica>
In-Reply-To: <m2het7jpgg.fsf@anano.mitica>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200110111955537.SM00161@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Oktober 2001 20:54 schrieb Juan Quintela:
> >>>>> "robert" == Robert Szentmihalyi
> >>>>> <robert.szentmihalyi@entracom.de> writes:
> >> >
> >> > For me Fn+F12 works.
>
> robert> unfortunately not for me....
>
> You need to have a partition created with the recovery CD, it
> don't work if you create it with normal fdisk (and it will
> destroy your data in the disk, do a backup first).

I have created the hibernation partition with lphdisk and it works 
under Windows 2000, so I guess there's nothing wrong with it.

>
> z>> > apm -s & apm -S fails.
>
> >> works only if you have a suspend-on-disk partition.
>
> robert> I have created one with lphdisk and it works under
> Win2k...
>
> robert> The HP support people say the new omnibook BIOS is not
> APM robert> compilant any more.
>
> I have the omnibook lastest BIOS as end of July, it will work
> only with Fn+F12.  I don't remind the version, can check when
> rebooting.

Mine reports:
PhoenixBIOS 4.0 Release 6.0
HP OMNIBOOK XE3 BIOS Revision GC.M1.63

Could you check yours?
I'd be really interested... 

>
> robert> ACPI only...
>
> robert> Suspend-to-disk with API is not yet supported and I can't
> use robert> software suspend because of reiserfs
>
> robert> I guess I have to wait for proper hibernation support
> with ACPI....
>
> I am also waiting for it, as I can not suspend to RAM, but
> suspend to disk is working nicely here (what is an advantage
> while waiting).
>
> Later, Juan.

so long,
 Robert
-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de
