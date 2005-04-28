Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVD1B4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVD1B4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 21:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVD1B4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 21:56:34 -0400
Received: from c-67-163-99-44.hsd1.tx.comcast.net ([67.163.99.44]:57313 "EHLO
	leaper.linuxtx.org") by vger.kernel.org with ESMTP id S261703AbVD1B4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 21:56:30 -0400
Date: Wed, 27 Apr 2005 20:54:46 -0500
From: "Justin M. Forbes" <jmforbes@linuxtx.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Chris Wright <chrisw@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [00/07] -stable review
Message-ID: <20050428015446.GA6513@linuxtx.org>
References: <20050427171446.GA3195@kroah.com> <42702AC4.2030500@yahoo.com.au> <20050428013342.GM23013@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504271951110.12903@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504271951110.12903@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 07:51:35PM -0600, Zwane Mwaikambo wrote:
> On Wed, 27 Apr 2005, Chris Wright wrote:
> 
> > * Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> > > Wanna take some buffer fixes?
> > 
> > Do they meet the -stable criteria?  If so, please send 'em over.
> 
> Shouldn't they see testing time in a tree first?

I would say that if they meet the stable criteria, testing time in another
tree is not really necessary.  Stable should be simple bug fixes, easy to
test.  In this case, the fact that Nick seems to think they might need a
run in mm first would tell me that at least some of them probably should
not be in the stable tree at this point.

Justin
