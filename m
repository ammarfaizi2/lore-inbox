Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWGKSnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWGKSnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWGKSnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:43:15 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:34059 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751178AbWGKSnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:43:14 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: Will there be Intel Wireless 3945ABG support?
Date: Tue, 11 Jul 2006 19:43:41 +0100
User-Agent: KMail/1.9.3
Cc: "John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net,
       linux-kernel@vger.kernel.org
References: <1152635563.4f13f77cjsmidt@byu.edu> <200607111909.22972.s0348365@sms.ed.ac.uk> <44B3ED29.4040801@gmail.com>
In-Reply-To: <44B3ED29.4040801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111943.41107.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 19:25, Alon Bar-Lev wrote:
> Alistair John Strachan wrote:
> > On Tuesday 11 July 2006 18:12, John W. Linville wrote:
> >> On Tue, Jul 11, 2006 at 10:32:43AM -0600, Joseph Michael Smidt wrote:
> >>> Will 2.6.18 or 2.6.19 support Intel Wireless 3945ABG?  Please cc me
> >>> since I am not subscribed.   Thanks.
> >>
> >> It will not be in 2.6.18.  Making 2.6.19 is not out of the question,
> >> but it may take some work.
> >
> > Has some agreement been met regarding the mandatory use of the binary
> > regulatory daemon? The webpage seems to suggest it is still necessary,
> > and I'm sure that would disqualify merging the driver with Linux proper.
>
> Why not?
> The whole point is running a system that you know you can support for many
> years, even without a vendor support...
> And to have a system that you know exactly what running in it...
> Having a binary closed source violate this.
>
> Also there is no good reason why supplying this daemon as closed source...
> All they wish is people don't mess with their frequencies, and sooner or
> later someone will...

Don't misinterpret me, that's exactly my feeling too. Ignoring the politics 
and questionable legality entirely, as a matter of practicality, when Intel 
inevitably abandon these cards 5 years from now and their daemon rots, will I 
still be able to use my wireless card? I think not.

Also, I can't see any reason why a mini-pci version of this couldn't work in a 
system other than x86/x86-64, even if Intel don't design such machines.

In my view, it would be unacceptable to merge.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
