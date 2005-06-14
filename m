Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVFNBOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVFNBOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 21:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFNBOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 21:14:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8498 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261284AbVFNBNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 21:13:53 -0400
Date: Mon, 13 Jun 2005 21:13:23 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Attempted summary of "RT patch acceptance" thread
In-reply-to: <42AE0EF8.1090509@opersys.com>
X-X-Sender: nico@localhost.localdomain
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, dwalker@mvista.com, paulmck@us.ibm.com,
       Andrea Arcangeli <andrea@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, lkml <linux-kernel@vger.kernel.org>,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.63.0506132052590.1667@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com>
 <42ADE334.4030002@opersys.com> <1118693033.2725.21.camel@dhcp153.mvista.com>
 <42ADEC0E.4020907@opersys.com> <1118694495.2725.32.camel@dhcp153.mvista.com>
 <42AE01EA.10905@opersys.com> <42AE04AE.8070107@opersys.com>
 <20050613221810.GA820@nietzsche.lynx.com> <42AE0875.8010001@opersys.com>
 <20050613222909.GA880@nietzsche.lynx.com> <42AE0EF8.1090509@opersys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005, Karim Yaghmour wrote:

> Bare in mind that I wasn't even talking about whether or not
> PREEMPT_RT was making it in. I was only talking about the logistics
> of inclusion of any RT extension. Please people, get a grip, we're
> just trying to figure out the best way to do this stuff.

The best way to do this stuff has already been outlined by Ingo himself, 
and as far as I know he's still the man leading the show.  And no one 
objected to his strategy so far.

There is just no rush.  It doesn't have to be integrated ASAP, and 
actually not before a while, and then certainly not in a disturbing way.  
Lots of things have to be cleaned up in the patch, and even in the 
current stock kernel for that matter, and Ingo even agreed to that.

So any discussion about merging of PREEMPT_RT into mainline is simply 
hand waving at this point.  Let it evolve and resume this discussion 
when there is actually something being proposed for merging into 
mainline.


Nicolas
