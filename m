Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313536AbSDLLbm>; Fri, 12 Apr 2002 07:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313539AbSDLLbl>; Fri, 12 Apr 2002 07:31:41 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:24285 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S313536AbSDLLbl>; Fri, 12 Apr 2002 07:31:41 -0400
Date: Fri, 12 Apr 2002 07:31:36 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: linux@aerythmic.be, linux-kernel@vger.kernel.org
Subject: Re: Stolen Memory <- i830M video chip
Message-Id: <20020412073136.53e533ed.fryman@cc.gatech.edu>
In-Reply-To: <20020412094323.B8997@crystal.2d3d.co.za>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is therefore a OEM BIOS problem. Dell was notified about this a long time
> ago - I thought they fixed it in the mean time. Try moaning about this to
> Asus as well...

this isn't fixed in the new dell C400 laptops (still).  however, i argue that
BIOS problem or no, a solution _does_ exist.  there is a 3rd party that
sells commercial X server drop-ins for new chipsets.  one of the guys here
bought their X server for $40 or so, and now has full-color & -resolution 
without getting a BIOS update.

so if it's a BIOS problem that can only be fixed by Dell, how were these guys
able to do the fix?  and why can't the open source guys (XFree or Linux kernel) 
seem to do the same?

-josh

ps > company is xig.com : Dell C400 w/generic I830-M support:
http://www.xig.com/Pages/Atop/LaptopIndividualSupportSpecs/Dell-IndividualLaptops/LatitudeC400.html

