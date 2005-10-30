Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVJ3VgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVJ3VgA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVJ3VgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:36:00 -0500
Received: from mail.suse.de ([195.135.220.2]:52613 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932347AbVJ3Vf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:35:59 -0500
From: Neil Brown <neilb@suse.de>
To: Greg KH <greg@kroah.com>
Date: Mon, 31 Oct 2005 08:35:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17253.15545.627386.416345@cse.unsw.edu.au>
Cc: Daniele Orlandi <daniele@orlandi.com>, linux-kernel@vger.kernel.org
Subject: Re: An idea on devfs vs. udev
In-Reply-To: message from Greg KH on Sunday October 30
References: <200510301907.11860.daniele@orlandi.com>
	<20051030221817.GA9335@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 30, greg@kroah.com wrote:
> On Sun, Oct 30, 2005 at 08:07:11PM +0200, Daniele Orlandi wrote:
> > 
> > So, why cannot we substitute the "dev" file within /sys with the actual device 
> > file?
> 
> Please read the archives, this comes up every few months or so.

..thus making it a Frequently Asked Question.  However it isn't
answered in the FAQ.

Any chance of writing a little FAQ entry for us and getting it into 

> Please read the FAQ at  http://www.tux.org/lkml/

Maybe it could replace entry 9.5:
  What's devfs and why is it a Good Idea (tm)?
:-)

NeilBrown

