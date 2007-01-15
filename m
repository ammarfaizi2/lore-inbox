Return-Path: <linux-kernel-owner+w=401wt.eu-S1750977AbXAOR3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXAOR3Q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbXAOR3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:29:16 -0500
Received: from ns2.suse.de ([195.135.220.15]:35143 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbXAOR3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:29:15 -0500
Date: Mon, 15 Jan 2007 18:29:12 +0100
From: Karsten Keil <kkeil@suse.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Tilman Schmidt <tilman@imap.cc>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, kkeil@suse.de
Subject: Re: any value to fixing apparent bugs in old ISDN4Linux?
Message-ID: <20070115172912.GA3323@pingi.kke.suse.de>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Tilman Schmidt <tilman@imap.cc>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	kkeil@suse.de
References: <Pine.LNX.4.64.0701150634270.1953@CPE00045a9c397f-CM001225dbafb6> <45ABB53C.5030100@imap.cc> <Pine.LNX.4.64.0701151216310.7260@CPE00045a9c397f-CM001225dbafb6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701151216310.7260@CPE00045a9c397f-CM001225dbafb6>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 12:17:37PM -0500, Robert P. J. Day wrote:
> On Mon, 15 Jan 2007, Tilman Schmidt wrote:
> 
> > Robert P. J. Day schrieb:
> > >   OTOH, since that code *is* in the allegedly obsolete old ISDN4Linux
> > > code, perhaps that entire part of the tree can just be junked.  but if
> > > it's sticking around, it should probably be fixed.
> >
> > Please do not remove isdn4linux just yet. It's true that it has been
> > marked as obsolete for quite some time, but it's still needed
> > anyway. Its designated successor, the CAPI subsystem, so far only
> > supports a very limited range of hardware. Dropping isdn4linux now
> > would leave the owners of some very popular ISDN cards out in the
> > cold.
> 
> that wouldn't be my decision, i just made a note of an oddity.  but if
> it's still in actual use, then it really should be re-labelled from
> "obsolete" to "deprecated," no?
> 

Good point.

-- 
Karsten Keil
SuSE Labs
ISDN development
