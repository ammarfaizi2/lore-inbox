Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSAGS7T>; Mon, 7 Jan 2002 13:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbSAGS7J>; Mon, 7 Jan 2002 13:59:09 -0500
Received: from ns.suse.de ([213.95.15.193]:2823 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285153AbSAGS6v>;
	Mon, 7 Jan 2002 13:58:51 -0500
Date: Mon, 7 Jan 2002 19:58:49 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, Paul Jakma <paulj@alphyra.ie>,
        <knobi@knobisoft.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <20020107185001.GK7378@kroah.com>
Message-ID: <Pine.LNX.4.33.0201071956410.16327-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Greg KH wrote:

> dietHotplug, a _very_ tiny implementation of /sbin/hotplug which is was
> created exactly for the initramfs stage:
> 	http://www.kernel.org/pub/linux/utils/kernel/hotplug/diethotplug-0.3.tar.gz

which reminds me of another initramfs issue. I noticed you included
dietlibc in the diethotplug (hence the name I guess), but has any
decision been made yet as to what's going to be chosen as an
initlibc/klibc ?

There are several small libc's out there, but I've not seen any
discussion either for or against any of them.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

