Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289239AbSANOCx>; Mon, 14 Jan 2002 09:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289242AbSANOCn>; Mon, 14 Jan 2002 09:02:43 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:56210 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289239AbSANOC1>; Mon, 14 Jan 2002 09:02:27 -0500
Date: Mon, 14 Jan 2002 16:00:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Eric S Raymond <esr@thyrsus.com>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <E16Q3fX-0001Bt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201141550370.9308-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Alan Cox wrote:
> Red Hat for one basically avoids ISA probing in favour of user guidance. We
> also use a standard kernel build and the more I think about this the more
> I think Erik's tool is trying to be too clever and should simply build
> a complete kernel set for the right cpu with the root fs and root fs block
> device built into it

I'm definately not a fan of automagic kernel configurations, there are way
too many variables. Frankly the way i see it distro kernels do a damn good
job as it is right now and i don't see anything wrong with going the RH
errata kernel style for upgrading kernels (ditto for Debian and their apt
kernel upgrades). All Aunt Tillie has to do is click on the update button.

Are ISA device questions really that much of a big problem? The way i see
it, the user would get flooded more with the plethora of PCI and USB
devices more than anything. Then again i might be missing the "Big
Picture" ;)

Regards,
	Zwane Mwaikambo

