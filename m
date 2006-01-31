Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWAaHNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWAaHNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWAaHNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:13:50 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:51079
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030351AbWAaHNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:13:50 -0500
Date: Mon, 30 Jan 2006 23:09:46 -0800
From: Greg KH <greg@kroah.com>
To: Jens Axboe <axboe@suse.de>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, 76306.1226@compuserve.com,
       nickpiggin@yahoo.com.au, Justin Forbes <jmforbes@linuxtx.org>,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 06/12] elevator=as back-compatibility
Message-ID: <20060131070946.GA25172@kroah.com>
References: <20060128020629.908825000@press.kroah.org> <20060128022102.GG17001@kroah.com> <20060128191932.GE9750@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128191932.GE9750@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 08:19:32PM +0100, Jens Axboe wrote:
> On Fri, Jan 27 2006, Greg KH wrote:
> > 2.6.15.2 -stable review patch.  If anyone has any objections, please let 
> > us know.
> 
> Well the patch is trivial enough, but I don't see it fitting the stable
> criteria to be honest. You would have needed this since 2.6.10 stable,
> and it's not fixing an oops or anything.
> 
> So I'd NAK this for 2.6.15.x

Ok, I dropped it.

thanks,

greg k-h
