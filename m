Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130549AbQLUJnu>; Thu, 21 Dec 2000 04:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbQLUJnb>; Thu, 21 Dec 2000 04:43:31 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:3335 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130549AbQLUJnX>; Thu, 21 Dec 2000 04:43:23 -0500
Date: Thu, 21 Dec 2000 04:13:26 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown PCI device?
In-Reply-To: <7yelz2f8hr.fsf@vador.mandrakesoft.com>
Message-ID: <Pine.LNX.4.31.0012210412560.748-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Dec 2000, Thierry Vignaud wrote:

>Date: 21 Dec 2000 10:07:12 +0100
>From: Thierry Vignaud <tvignaud@mandrakesoft.com>
>To: Mike A. Harris <mharris@opensourceadvocate.org>
>Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
>Content-Type: text/plain; charset=us-ascii
>Subject: Re: Unknown PCI device?
>
>"Mike A. Harris" <mharris@opensourceadvocate.org> writes:
>
>> Anyone know what this is?
>>
>> 00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050 (rev 30)
>>         Flags: medium devsel
>
>if its pci id is 0x11063050, then it's a VIA Power Management Controller.

00:07.3 Class 0600: 1106:3050 (rev 30)
        Flags: medium devsel


Yip.  Someone might want to update the PCI ID db, or whatever
with that..



----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

There are two major products that come out of Berkeley: LSD and BSD.
We don't believe this to be a coincidence.
   -- Jeremy S. Anderson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
