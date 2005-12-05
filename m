Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVLELkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVLELkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 06:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVLELkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 06:40:49 -0500
Received: from gate.in-addr.de ([212.8.193.158]:38114 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932380AbVLELks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 06:40:48 -0500
Date: Mon, 5 Dec 2005 12:40:28 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205114028.GD5148@marowsky-bree.de>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org> <20051204232454.GG8914@kroah.com> <20051205062609.GA7096@alpha.home.local> <20051205105536.GB5148@marowsky-bree.de> <20051205113420.GA9149@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051205113420.GA9149@alpha.home.local>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-12-05T12:34:20, Willy Tarreau <willy@w.ods.org> wrote:

> > Anyway, good luck to you.
> > 
> > The current 2.6.x.y-stable series is quite sane, because they are
> > essentially just fixing very critical bugs in very recent kernels, with
> > little back porting effort.
> 
> I agree it is sane. The problem is that it does not exist for long enough.
> When you have 2.6.14.X working perfectly and you need a fix for a newly
> discovered security fix which only exists in 2.6.15.Y, then you have to
> leave 2.6.14 and enter 2.6.15. That is the problem, because for just a
> fix, you change megabytes of source code which will bring their equivalent
> in bugs.

As I said, please, go on maintaining a release for a longer period of
time.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

