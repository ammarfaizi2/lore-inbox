Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVAMQIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVAMQIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVAMQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:08:20 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:16085 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S261675AbVAMQAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:00:50 -0500
Message-ID: <41E69B30.8040406@enterprise.bidmc.harvard.edu>
Date: Thu, 13 Jan 2005 11:00:48 -0500
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:

>So I'd not personally mind some _totally_ open list. No embargo at all, no 
>limits on who reads it. The more, the merrier. However, I think my 
>personal preference is pretty extreme in one end
>

I'm tipping my security hat to Linus (and somewhat away from RFPolicy) 
on this one.  Keeping a large organization free from viruses and malware 
becomes increasingly entertaining the more "day zero" variants there 
are.  And recently, we've seen a lot for the windoze platform here; at 
least one major anti-virus player thanks us for sending them infected 
executables to analyze.  Waiting for some embargo to allow a researcher 
to claim credit just does not work.  We spend all of our time swatting 
flies, waiting for a vendor fix; yet a disclose-without-delay 
quick-and-dirty fix would have saved so many staff hours.


>So it's embarrassing to everybody if the kernel.org kernel has a security
>hole for longer than vendor kernels, but at the same time, most _users_
>run vendor kernels anyway
>

Not here!  :-)  All of my security infrastructure runs kernel.org 
kernels.  (I don't want any vendor "goodies" hidden in places I don't 
know about.)  I punch a button on my heavily-hacked Slackware boxen, and 
the latest kernel, the latest internet-facing servers, the latest 
critical libraries are automatically downloaded, compiled and installed 
whenever newer version numbers exist.  Time to a patched system from 
when the author creates a patch is measured in hours; I compare that to 
the day(s) or weeks I can wait for a vendor to get around to doing the 
same thing.

Kris

