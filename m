Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281668AbRKUNvW>; Wed, 21 Nov 2001 08:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281381AbRKUNvN>; Wed, 21 Nov 2001 08:51:13 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:7897 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281050AbRKUNvG>; Wed, 21 Nov 2001 08:51:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: hps@intermeta.de, "Henning P. Schmiedehausen" <mailgate@hometree.net>,
        linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
Date: Wed, 21 Nov 2001 13:51:12 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011120190316.H19738@vnl.com> <E166TCM-0004VH-00@lilac.csi.cam.ac.uk> <9tg371$ja3$1@forge.intermeta.de>
In-Reply-To: <9tg371$ja3$1@forge.intermeta.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166XmJ-0004HV-00@lilac.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 November 2001 11:29 am, Henning P. Schmiedehausen wrote:
> James A Sutherland <jas88@cam.ac.uk> writes:
> >On Tuesday 20 November 2001 9:27 pm, David Woodhouse wrote:
> >> amon@vnl.com said:
> >> > In any case, here is the problem:
> >> > 	NIC on motherboard, Realtek
> >> > 	NIC on PCI card, Realtek
> >> > 	Monolithic (no-module) kernel
> >> > 	Motherboard must be set to eth0
> >>
> >> Why must the motherboard be set to eth0? Why not just configure it as it
> >> gets detected?
> >
> >He has some software licensing thing which checks the MAC address of eth0.
> >
> >Of course, what he could do is change the MAC address of eth0 to whatever
> > the licensing software wants... :-)
>
> One could imagine a module to read the MAC address from the eeprom and
> not from the Interface.. Makes this scenario not impossible but much
> harder.

Apart from depending on the specific NIC in use, probably easy to circumvent. 
Especially with EEPROMs. But discussing this probably violates the UK's CDPA 
(our answer to DMCA, but snuck onto the books in '88) prohibition on 
communicating information about circumvention...


James.
