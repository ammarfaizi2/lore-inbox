Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269763AbRHDCbc>; Fri, 3 Aug 2001 22:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269764AbRHDCbX>; Fri, 3 Aug 2001 22:31:23 -0400
Received: from weta.f00f.org ([203.167.249.89]:15504 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269763AbRHDCbL>;
	Fri, 3 Aug 2001 22:31:11 -0400
Date: Sat, 4 Aug 2001 14:31:55 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Cc: Mark Atwood <mra@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
Message-ID: <20010804143155.G18108@weta.f00f.org>
In-Reply-To: <m33d78de7d.fsf@flash.localdomain> <20010804132159.F18108@weta.f00f.org> <996888738.24442.1.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996888738.24442.1.camel@tduffy-lnx.afara.com>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 06:32:18PM -0700, Thomas Duffy wrote:

    so, what happens when you have two eth cards that use the same module?
    in the isa land, the order you pass the io=0x300,0x240 would determine
    which order the eth?'s go to...how about in the pci world?

when the pci module loads, it find all devices and registers them



  --cw
