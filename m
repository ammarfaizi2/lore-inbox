Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266150AbRF2SjZ>; Fri, 29 Jun 2001 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266151AbRF2SjP>; Fri, 29 Jun 2001 14:39:15 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:26541 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S266150AbRF2SjA>; Fri, 29 Jun 2001 14:39:00 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Holger Lubitz <h.lubitz@internet-factory.de>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 29 Jun 2001 10:26:44 -0700 (PDT)
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <3B3C85FD.B018746D@internet-factory.de>
Message-ID: <Pine.LNX.4.33.0106291024240.21533-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

back when I was doing PC repair (1.x kernel days) I started useing linux
becouse the boot messages gave me so much info about the system (I started
to keep a Slackware boot/root disk set on hand so when faced with a
customer machine I could boot and see what hardware was actually
installed)

make a boot option to turn on the verbose mode if you want, but don't
eliminate it completely.

David Lang

 On Fri, 29 Jun 2001, Holger Lubitz wrote:

> Date: Fri, 29 Jun 2001 15:43:25 +0200
> From: Holger Lubitz <h.lubitz@internet-factory.de>
> To: linux-kernel@vger.kernel.org
> Newsgroups: lists.linux.kernel
> Subject: Re: Cosmetic JFFS patch.
>
> Miquel van Smoorenburg proclaimed:
> > You know what I hate? Debugging stuff like BIOS-e820, zone messages,
> > dentry|buffer|page-cache hash table entries, CPU: Before vendor init,
> > CPU: After vendor init, etc etc, PCI: Probing PCI hardware,
> > ip_conntrack (256 buckets, 2048 max), the complete APIC tables, etc
>
> Well, I _like_ the fact that my machine tells me all that when booting
> (ok, maybe the APIC tables are a little bit much). Believe it or not -
> the detailed boot messages were one of the reasons I chose Linux over
> BSD back in 1993 when I started. I think it gives a valuable feeling for
> what the OS is up to - even to the unexperienced.
>
> A boot parameter for the verbosity would be ok, though. But I'd still
> vote for the default to be pretty verbose. Leave it to the distributors
> to disable it, if they want.
>
> After all - how often does the average linux machine boot? Once a day at
> most. Mine usually run until the next kernel upgrade. But then again,
> I'm not a kernel hacker, so this is to be taken more as a users point of
> view.
>
> Holger
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
