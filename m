Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbTBOIVC>; Sat, 15 Feb 2003 03:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbTBOIVC>; Sat, 15 Feb 2003 03:21:02 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:32130 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S264657AbTBOIVB>;
	Sat, 15 Feb 2003 03:21:01 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Sat, 15 Feb 2003 01:27:07 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Lynch <rusty@linux.co.intel.com>, Pavel Machek <pavel@ucw.cz>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030215082707.GE13148@host109.fsmlabs.com>
References: <1045106216.1089.16.camel@vmhack> <1045160506.1721.22.camel@vmhack> <20030213230408.GA121@elf.ucw.cz> <1045260726.1854.7.camel@irongate.swansea.linux.org.uk> <20030214213542.GH23589@atrey.karlin.mff.cuni.cz> <1045264651.13488.40.camel@vmhack> <1045274042.2961.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045274042.2961.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} On Fri, 2003-02-14 at 23:17, Rusty Lynch wrote:
} > The watchdog infrastructure would just show what ever integer the driver
} > provides via the watchdog_ops.get_temperature() function pointer, so it
} > would be up to the driver developer to decide if the data is really
} > Fahrenheit or whatever.
} 
} We do need to be sure they all agree about it however 8)

Just to make sure no-one is happy except physicists, I suggest Kelvin.  I
also suggest we spell disk/disc as "disck".
