Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbTLVRGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbTLVRGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 12:06:22 -0500
Received: from www.stereoconnection.CA ([216.16.235.58]:55509 "EHLO
	nic.NetDirect.CA") by vger.kernel.org with ESMTP id S264347AbTLVRGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 12:06:21 -0500
Date: Mon, 22 Dec 2003 12:05:57 -0500
From: Chris Frey <cdfrey@netdirect.ca>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Maciej Zenczykowski <maze@cela.pl>, Arnaud Fontaine <arnaud@andesi.org>,
       Mike Fedyk <mfedyk@matchmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
Message-ID: <20031222120557.A21530@netdirect.ca>
References: <20031219224402.GA1284@scrappy> <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl> <20031222021659.GA4857@ip68-4-255-84.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031222021659.GA4857@ip68-4-255-84.oc.oc.cox.net>; from barryn@pobox.com on Sun, Dec 21, 2003 at 06:17:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 06:17:00PM -0800, Barry K. Nathan wrote:
> On Sat, Dec 20, 2003 at 12:35:24AM +0100, Maciej Zenczykowski wrote:
> > you did run memtest for a minimum dozen hours? sometimes it takes that 
> > long to find errors...
> 
> On one machine (with a bad power supply, as it turned out) it took
> memtest86 almost 18 hours to report an error. So 12 hours isn't enough
> either.
> 
> (On a related note, one machine that I tested with mprime's Torture Test
> <http://www.mersenne.org/> took I think close to 43 hours to show a
> failure. In that case I don't know if the failure was the CPU or the
> motherboard, because in the end both failed on that system.)

At what point do people start suspecting the kernel?

I mean, I would hope the linux kernel is not so badly written as to stress
the machine 24/7.  So after 12 hours of running memtest86 with clean
results, does that not begin to point to a software error rather than
hardware?

- Chris

