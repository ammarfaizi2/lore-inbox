Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbSAGT1M>; Mon, 7 Jan 2002 14:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285484AbSAGT0y>; Mon, 7 Jan 2002 14:26:54 -0500
Received: from ns.suse.de ([213.95.15.193]:39689 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285498AbSAGT0f>;
	Mon, 7 Jan 2002 14:26:35 -0500
Date: Mon, 7 Jan 2002 20:26:32 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Patrick Mochel <mochel@osdl.org>, Paul Jakma <paulj@alphyra.ie>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <200201071904.g07J4Wf02751@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0201072024340.16327-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Richard Gooch wrote:

> It still eludes me why a new device FS was developed when devfs
> already has the mechanisms that are needed.

For one, driverfs can be made mandatory. Sure we could do the same for
devfs, but there are probably an army of people who don't want
a mandatory devfs.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

