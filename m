Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbRBABQl>; Wed, 31 Jan 2001 20:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129333AbRBABQb>; Wed, 31 Jan 2001 20:16:31 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:32266 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129289AbRBABQR>; Wed, 31 Jan 2001 20:16:17 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE61E@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: ACPI fix + comments
Date: Wed, 31 Jan 2001 14:37:38 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem the diff below fixes is a BIOS issue - the _STA 
> control method
> > should always be returning a value, but in this case it doesn't. The
> > approach we're taking is "get everything working and THEN 
> worry about broken
> > ACPI implementations" and hopefully in the meantime, people 
> will release
> > fixed BIOSs ;-).
> 
> Where is that diff? I do not see it.

I apologize, I was referring to your patch - i.e. your patch is a workaround
for a bios issue.

-- Andy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
