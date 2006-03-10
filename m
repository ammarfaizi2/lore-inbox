Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWCJIDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWCJIDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCJIDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:03:09 -0500
Received: from mail.gmx.de ([213.165.64.20]:17043 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751073AbWCJIDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:03:08 -0500
X-Authenticated: #428038
Date: Fri, 10 Mar 2006 09:03:04 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
Message-ID: <20060310080304.GA14650@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> <200603081151.33349.jk-lkml@sci.fi> <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2006, Anshuman Gholap wrote:

> if there was binary allowed (with any license) maybe dlink themself
> would build a driver, make documentation and provide it on CD, just
> see how much effort would be saved and in end he would get more time
> to treat his patients.

And you assume doctor would care to compile the kernel himself in his
working hours, rather than ask the NOC staff of $hospital to do that for
him?  You expect Linux would ship with these binary drivers for any
device?  All major Linux distributions (including Turbo, Red Hat and
Fedora, Novell, SUSE and Opensuse, Debian, Ubuntu, Gentoo) could work
out a single way of installing drivers?  Interesting.

> I have thousands of similar scenarios. Even I wont mind the luxury of
> making hardware just working and not going to google>>download src>>if
> bug/error found>>go to forums post thread>>hang on irc and bug
> ppl>>get more things compiled done >>if work then enjoy>> or wait for
> the philanthropic coder to solve bug and release new ver.

That coder needs to be provided with full specs, and that is what
usually does not happen, because then the hardware isn't as easily
exchangable to save 0.003 US$ per device, many vendors fear their
"intellectual property" (as though thoughts had property rights, brains
have...).

-- 
Matthias Andree
