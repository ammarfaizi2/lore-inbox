Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSFCJw7>; Mon, 3 Jun 2002 05:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317343AbSFCJw6>; Mon, 3 Jun 2002 05:52:58 -0400
Received: from 213-145-181-73.dd.nextgentel.com ([213.145.181.73]:50761 "EHLO
	sevilla.gnome.no") by vger.kernel.org with ESMTP id <S317342AbSFCJw4>;
	Mon, 3 Jun 2002 05:52:56 -0400
Subject: Re: INTEL 845G Chipset IDE Quandry
From: Kjartan Maraas <kmaraas@online.no>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Anthony Spinillo <tspinillo@linuxmail.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1023066825.3439.58.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 03 Jun 2002 13:49:26 +0200
Message-Id: <1023104966.26418.11.camel@sevilla.gnome.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 2002-06-03 kl. 03:13 skrev Alan Cox:
> On Sun, 2002-06-02 at 22:30, Vojtech Pavlik wrote:
> > On Sun, Jun 02, 2002 at 09:36:35PM +0200, Martin Dalecki wrote:

[SNIP]

> > Note it works with 2.5 already. We have the device there.
> 
> If you look at why it fails it fails not because it isnt in the table
> but because the PCI device has not been allocated resources properly by
> the BIOS
> 

Back when I talked to Andre about this problem it sounded to me like he
said it was a genuine bug that was fixed in the ide-convert patches.
Maybe I'm confusing two issues here...

Cheers
Kjartan

