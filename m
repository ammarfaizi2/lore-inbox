Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbSAGTT3>; Mon, 7 Jan 2002 14:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285347AbSAGTTU>; Mon, 7 Jan 2002 14:19:20 -0500
Received: from ns.suse.de ([213.95.15.193]:64520 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285316AbSAGTTK>;
	Mon, 7 Jan 2002 14:19:10 -0500
Date: Mon, 7 Jan 2002 20:19:08 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <20020107190643.GA8413@kroah.com>
Message-ID: <Pine.LNX.4.33.0201072017200.16327-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Greg KH wrote:

> I don't know.  I asked the dietLibc people if they would be willing to
> create a stripped down version of it and help port it to the remaining
> archs that Linux supports, but dietLibc doesn't, and didn't hear
> anything back.

That doesn't fill me with confidence. This thing will need
maintainence after initial merge.

> It doesn't look like much work to do the stripping (I did a bunch of it
> for the latest version of dietHotplug) but the porting, I have no idea
> of what is needed there.
> Anyone want to start up a klibc project? :)

That's not half a bad idea. If we want a _maintained_ libc for the kernel,
having it maintained by kernel folks may make sense. There's nothing
stopping us borrowing bits from dietlibc and friends after all.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

