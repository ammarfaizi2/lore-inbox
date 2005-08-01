Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVHASS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVHASS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVHASSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:18:55 -0400
Received: from atpro.com ([12.161.0.3]:20487 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261459AbVHASQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:16:53 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Mon, 1 Aug 2005 14:16:27 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: James Bruce <bruce@andrew.cmu.edu>, Lee Revell <rlrevell@joe-job.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050801181627.GA31947@voodoo>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	James Bruce <bruce@andrew.cmu.edu>,
	Lee Revell <rlrevell@joe-job.com>,
	Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
References: <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <20050731220754.GE7362@voodoo> <20050731223616.GB27580@elf.ucw.cz> <20050801034940.GC24130@mail> <20050801072600.GM27580@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801072600.GM27580@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/05 09:26:00AM +0200, Pavel Machek wrote:
> > 
> > And there are older machines that won't boot with it enabled. The machine
> > I'm typing this on has a really shitty ACPI implementation, I don't remember
> > the details because it's been so long but I know that I have to disable ACPI 
> > for it to work right.
> 
> If it was long ago, you probably want to try again and file a bug
> report if still broken.

I may do that, but I don't need ACPI on the machine so I've just always
disabled it and figured it was a BIOS problem that won't be fixed since
there have been no BIOS updates for this board since '03.

> 								Pavel

Jim.

