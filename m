Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbSJNPGA>; Mon, 14 Oct 2002 11:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSJNPGA>; Mon, 14 Oct 2002 11:06:00 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:29703 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S261700AbSJNPF5>;
	Mon, 14 Oct 2002 11:05:57 -0400
Date: Mon, 14 Oct 2002 11:11:47 -0400
From: Rob Radez <rob@osinvestor.com>
To: Dave Jones <davej@codemonkey.org.uk>, Wim Van Sebroeck <wim@iguana.be>,
       Rob Radez <rob@osinvestor.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Cc: Matt_Domsch@dell.com
Subject: Re: Watchdog drivers
Message-ID: <20021014111147.Q16698@osinvestor.com>
References: <20021013234308.P23142@flint.arm.linux.org.uk> <Pine.LNX.4.33L2.0210131615480.22520-100000@dragon.pdx.osdl.net> <20021013215726.P16698@osinvestor.com> <20021014101209.A18123@medelec.uia.ac.be> <20021014122239.GA29240@suse.de> <20021014144158.A19209@medelec.uia.ac.be> <20021014130441.GA528@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014130441.GA528@suse.de>; from davej@codemonkey.org.uk on Mon, Oct 14, 2002 at 02:04:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 02:04:41PM +0100, Dave Jones wrote:
> They remain character devices, so drivers/char/watchdog/  gets my vote.
> Any nay-sayers ?

I'm all in favor of drivers/char/watchdog/, but when I asked way back when,
I could never get a response from anyone upstream willing to take patches.
Also, I've got patches around from Matt Domsch that did the move, and changed
around the necessary drivers/char/ files.  I haven't been keeping them up-to-
date, maybe Matt has.

Regards,
Rob Radez
