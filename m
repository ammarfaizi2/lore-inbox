Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbVLFDIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbVLFDIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbVLFDIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:08:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15123
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751499AbVLFDIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:08:31 -0500
Date: Tue, 6 Dec 2005 04:08:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206030828.GA823@opteron.random>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43944F42.2070207@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 09:31:30AM -0500, Brian Gerst wrote:
> The problem with this statement is that Linux users are a drop in the 
> bucket of sales for this hardware.  Boycotting doesn't cost the vendors 
> enough to make them care.  And this does nothing for people who are 
> converting over to Linux, and didn't buy hardware with that 
> consideration in mind.

Effectively this is why 3d drivers are the only thing we litearlly lost
control of. But my email was general. I wasn't only speaking of 3d
hardware.

For 3d you're very well right, but once linux becomes mainstream in the
desktop, things could change.

Also note, I've some 3d on my laptop but I need no binary only drivers
for it, so there's some option.

Currently in KLive I can see there are about 44% of the users with the
nvidia driver loaded (once I have time to work on klive again, I'll
make the new data browsable on the web, I had to query the db by hand to
see it right now, ironically there are about 80 sessions where the
_only_ driver loaded is the nvidia one and everything else is static ;).

> The only way to break the stalemate is to reverse engineer drivers. 
> Turning the screws tighter isn't going to make open drivers magically 
> appear.  More likely, the vendors will abandon Linux as being too 
> hostile and/or too costly to support, leaving everybody back at square one.

Let's not forget they make money selling the hardware, the binary only
driver is free. And releasing an open source driver if something will
decrease their maintainance costs. The only thing this binary only
driver does is to avoid them _risks_, but they gain no money by keeping
it binary only. So the day they will be losing money by keeping the
driver binary only, I expect they may open it. They simply have no
reason to do it right now.

However this will only work out if we exercise our buyer rights (again
in general). To make the counter example, if we would suddently start to
prefer hardware with binary only drivers, then the doomsay scenario may
materialize with quick erosion.

In the meantime I don't like gratuitous breakages, I prefer that they
open it because it makes sense for them. Breaking it gratuitously is
what could make linux hostile and too costly to support IMHO.
