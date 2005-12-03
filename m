Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVLCRx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVLCRx4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVLCRxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:53:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63239 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932110AbVLCRxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:53:55 -0500
Date: Sat, 3 Dec 2005 18:53:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Ranson <david@unsolicited.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203175355.GL31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4391D335.7040008@unsolicited.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 05:17:41PM +0000, David Ranson wrote:
> Steven Rostedt wrote:
> 
> >udev ;)
> >
> >http://seclists.org/lists/linux-kernel/2005/Dec/0180.html
> >
> >
> Ahh OK .. I don't use it, so wouldn't have been affected. That's one
> userspace interface broken during the series, does anyone have any more?

- support for ipfwadm and ipchains was removed during 2.6
- devfs support was removed during 2.6
- removal of kernel support for pcmcia-cs is pending
- ip{,6}_queue removal is pending
- removal of the RAW driver is pending

> David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

