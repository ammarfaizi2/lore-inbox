Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTLLTTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLLTTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:19:34 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:32992 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261807AbTLLTTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:19:32 -0500
Date: Fri, 12 Dec 2003 12:29:55 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Josh McKinney <forming@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031212192955.GA656@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com> <200312111912.27811.ross@datscreative.com.au> <1071165161.2271.22.camel@big.pomac.com> <20031211182108.GA353@tesore.local> <3FD98A1F.901@nishanet.com> <20031212165929.GA187@tesore.local> <20031212181827.GA3862@forming>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212181827.GA3862@forming>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 01:18:27PM -0500, Josh McKinney wrote:
> 
> The thing that strikes me funny is that you get no crashes with the
> updated BIOS and Disconnect on, but without the updated BIOS we have
> to turn disconnect off with athcool or the patch?  This makes me think
> that there is some voodoo going on in the BIOS update that they aren't
> saying, surprise surprise, 

Yes, it is weird.  I've now asked shuttle for more information.

> or something is just slowing down the time
> it takes for it to crash.  I say this because I have gone 5+ days
> without any of the patches from these threads, acpi apic lapic
> enabled, and CPU disconnect on as stated by athcool.  This was with
> much stress testing, idle time, etc.  One day I just ran a grep that I
> have done probably 30 times and boom, hang.  

I hope this is not the case!  The one/two grep test worked flawlessly, but now if it's delayed, then I can't do that anymore.

(but at least I have the bios option now! heh)

I suggest you reference the Shuttle AN35 12-05-2003 BIOS, and maybe Bob's MSI, when you talk to Asus.  If they can do it, then Asus should be able as well.

Jesse
