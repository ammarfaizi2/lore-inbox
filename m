Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130938AbRAYV3V>; Thu, 25 Jan 2001 16:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131850AbRAYV3M>; Thu, 25 Jan 2001 16:29:12 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:5389 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130938AbRAYV2y>; Thu, 25 Jan 2001 16:28:54 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE5E1@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Terje Rosten'" <terjeros@phys.ntnu.no>, Ondrej Sury <ondrej@globe.cz>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.1-pre10 slowdown at boot.
Date: Thu, 25 Jan 2001 13:28:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is too. For now, remove ACPI support.

-- Andy
(ACPI maintainer)

> -----Original Message-----
> From: Terje Rosten [mailto:terjeros@phys.ntnu.no]
> Sent: Thursday, January 25, 2001 12:23 PM
> To: Ondrej Sury
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.1-pre10 slowdown at boot.
> Importance: High
> 
> 
> * Ondrej Sury
> | 
> | 2.4.1-pre10 slows down after printing those (maybe ACPI or 
> reiserfs issue),
> | and even SysRQ-(s,u,b) is not imediate and waits several 
> (two+) seconds
> | before (syncing,remounting,booting).
> 
> I'm also seeing this. I think it's ACPI related, I am not using
> reiserfs. I have similar hardware.
> 
> 
>  - terje
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
