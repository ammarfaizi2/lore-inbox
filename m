Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVAMBw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVAMBw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVAMBwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:52:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5156
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261456AbVALVUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:20:19 -0500
Date: Wed, 12 Jan 2005 22:20:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112212031.GE26799@dualathlon.random>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112122711.S24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112122711.S24171@build.pdx.osdl.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:27:11PM -0800, Chris Wright wrote:
> The two goals: 1) timely response, fix, dislosure; and 2) not leaving
> vendors with pants down; don't have to be mutually exclusive.

All vendors are normally ready way before the end of the embargo.
I would suggest the slowest of all vendors will enforce the date (i.e.
all vendors propose a date, and the longest one will be choosen like a
reverse auction, the worst offer wins), with a maximum delay of 1 month
(or whatever else). To guarantee everyone will go as fast as possible
the date proposed by every different vendor can be published in the
final report. Just keeping in mind that the more archs involved, the
more kernels have to be built and the slower will be a vendor. So a
difference of a few days just to build and test everything is very
reasonable and not significant, but this will avoid differences of
>1week and it'll avoid the unnecessary delays when everybody is ready to
publish but nobody can (which personally is the only thing that would
annoy me if I were a customer). This will also raise the attention and
it'll increase the stress to get things done ASAP since there'll be a
reward.  Nothing gets done if there's no reward.
