Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266021AbRF2Nnt>; Fri, 29 Jun 2001 09:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266055AbRF2Nnk>; Fri, 29 Jun 2001 09:43:40 -0400
Received: from darkstar.internet-factory.de ([195.122.142.9]:33471 "EHLO
	darkstar.internet-factory.de") by vger.kernel.org with ESMTP
	id <S266021AbRF2Nn1>; Fri, 29 Jun 2001 09:43:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: Cosmetic JFFS patch.
Date: Fri, 29 Jun 2001 15:43:25 +0200
Organization: Internet Factory AG
Message-ID: <3B3C85FD.B018746D@internet-factory.de>
In-Reply-To: <Pine.LNX.4.33.0106281040000.10308-100000@localhost.localdomain> <Pine.LNX.4.33.0106281057170.15199-100000@penguin.transmeta.com> <20010628131641.5e10ecca.reynolds@redhat.com> <9hfter$9e7$1@ncc1701.cistron.net>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 993822206 13160 195.122.142.158 (29 Jun 2001 13:43:26 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 29 Jun 2001 13:43:26 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac21 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg proclaimed:
> You know what I hate? Debugging stuff like BIOS-e820, zone messages,
> dentry|buffer|page-cache hash table entries, CPU: Before vendor init,
> CPU: After vendor init, etc etc, PCI: Probing PCI hardware,
> ip_conntrack (256 buckets, 2048 max), the complete APIC tables, etc

Well, I _like_ the fact that my machine tells me all that when booting
(ok, maybe the APIC tables are a little bit much). Believe it or not -
the detailed boot messages were one of the reasons I chose Linux over
BSD back in 1993 when I started. I think it gives a valuable feeling for
what the OS is up to - even to the unexperienced.

A boot parameter for the verbosity would be ok, though. But I'd still
vote for the default to be pretty verbose. Leave it to the distributors
to disable it, if they want.

After all - how often does the average linux machine boot? Once a day at
most. Mine usually run until the next kernel upgrade. But then again,
I'm not a kernel hacker, so this is to be taken more as a users point of
view.

Holger
