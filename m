Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292899AbSBVPUj>; Fri, 22 Feb 2002 10:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292898AbSBVPU3>; Fri, 22 Feb 2002 10:20:29 -0500
Received: from grisu.bik-gmbh.de ([194.233.237.82]:43280 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S292899AbSBVPUX>; Fri, 22 Feb 2002 10:20:23 -0500
Date: Fri, 22 Feb 2002 16:21:54 +0100
From: Florian Hars <florian@hars.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "vojtech@suse.cz" <VojtechPavlik@bik-gmbh.de>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridges in 2.4.18-rc3
Message-ID: <20020222152154.GA10285@bik-gmbh.de>
In-Reply-To: <20020222143640.GA22031@bik-gmbh.de> <Pine.LNX.4.21.0202221128270.29093-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202221128270.29093-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Fri, 22 Feb 2002, Florian Hars wrote:
> > Right now I am running a 2.4.18-pre9 with a slightly modified
> > drivers/ide/(timing.h|via82xxx.c) from 2.5.2, and it works with
> > my vt8233a and an UDMA-100 disk, but this is of course not a 
> > conservative change. Maybe the patch by Vojtech Pavlik mentioned
> > in the message I referred to above is less radical.
> 
> Could you please send me this patch ?

I don't have it, I use the kludge with files copied from 2.5. I Cc this
message to Vojtech Pavlik, maybe he can send the patch he sent to
Jens Axboe to you, too.

Yours, Florian
