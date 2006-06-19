Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWFSVQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWFSVQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWFSVQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:16:29 -0400
Received: from smtp2.ist.utl.pt ([193.136.128.22]:57772 "EHLO smtp2.ist.utl.pt")
	by vger.kernel.org with ESMTP id S964893AbWFSVQ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:16:28 -0400
From: Claudio Martins <ctpm@ist.utl.pt>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Date: Mon, 19 Jun 2006 22:16:19 +0100
User-Agent: KMail/1.9.1
Cc: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606192216.20355.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 19 June 2006 21:00, linux-os (Dick Johnson) wrote:
> You accelerate nothing. Bit heaven? A CPU without a fan will go into
> a cold, cold, shutdown, requiring a hardware reset to get it out of
> that latched, no internal clock running, mode. Try it. I have had
> broken plastic heat-sink hold-downs let the entire heat-sink fall off
> the CPU. The machine just stops. I didn't know why it was stopping

 That may well be true for Intel Pentium 4 and AMD Ahtlon64/Opteron CPUs but 
it is definitely *not* what happens on older AMD CPUs. Actually we have had a 
case of smoke coming out of a box when the heatsink fan on an Ahtlon XP CPU 
stopped. You could still smell the burnt plastic from the socket the next day 
in the room ;-)
 And I personally know of a least another case with an Athlon XP.

 I think Intel used to be better than AMD concerning CPU casing and the size 
of the area in thermal contact with the heatsink, but not anymore. 
Opteron/Athlon64 case seems to be at least as good as Intel's, and the chips 
should now have thermal throttling, though I haven't tried it!

Regards

Cláudio

