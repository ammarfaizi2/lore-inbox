Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSAGHm7>; Mon, 7 Jan 2002 02:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289006AbSAGHmt>; Mon, 7 Jan 2002 02:42:49 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:60432 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S289005AbSAGHmh>; Mon, 7 Jan 2002 02:42:37 -0500
Date: Mon, 7 Jan 2002 08:42:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020107084231.A31858@suse.cz>
In-Reply-To: <20020106220336.A30738@suse.cz> <E16NLb4-0006n5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16NLb4-0006n5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 06, 2002 at 10:16:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 10:16:53PM +0000, Alan Cox wrote:
> > I don't propose having human-readable output of DMI data in /proc, just
> > the binary data much like /proc/bus/pci has. That isn't much bloat in
> > kernel, and is a clearly defined interface, unlike reading /dev/kmem.
> 
> kmem is a cleanly defined interface

For reading the memory contents, not for searching for BIOS data.
Anyway, I see this discussion doesn't lead anywhere, so I guess I'd
better just stop.

-- 
Vojtech Pavlik
SuSE Labs
