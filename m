Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282338AbRKXBtH>; Fri, 23 Nov 2001 20:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282342AbRKXBsw>; Fri, 23 Nov 2001 20:48:52 -0500
Received: from holomorphy.com ([216.36.33.161]:1698 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S282338AbRKXBsX>;
	Fri, 23 Nov 2001 20:48:23 -0500
Date: Fri, 23 Nov 2001 17:48:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: DecStation 4000 info wanted
Message-ID: <20011123174804.A10965@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011124010313.53fda57f.imolton@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011124010313.53fda57f.imolton@clara.net>; from imolton@clara.net on Sat, Nov 24, 2001 at 01:03:13AM +0000
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 01:03:13AM +0000, Ian Molton wrote:
> Im wondering... does anyone have information on the care and feeding of
> Decstation4000s ?
> I have a DecStation 4000 (mips based, IIRC), which I would LOVE to run
> Linux on.
> It has no internal OS AFAICT, although it has a SCSI HDD, and some sort of
> bootloader.
> It used to boot over a network.
> what do I need to do to make it boot linux?

Short answer: kernel hacking.

You might want to subscribe to linux-mips@oss.sgi.com and visit
irc.openprojects.net #mipslinux, which are more appropriate fora for
this. There is also a site dedicated to Linux on DecStations at

	http://decstation.unix-ag.org/

which distributes a port of 2.2.x to DecStations. It makes no reference
to DecStation 4000's so you may well be faced with porting it yourself.


Cheers,
Bill
