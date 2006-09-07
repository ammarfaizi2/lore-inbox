Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422641AbWIGCIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbWIGCIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWIGCIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:08:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44250 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422641AbWIGCIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:08:36 -0400
Date: Wed, 6 Sep 2006 19:08:01 -0700
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/37] -stable review
Message-ID: <20060907020801.GA20011@suse.de>
References: <20060906225444.GA15922@kroah.com> <20060906233357.GB25473@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906233357.GB25473@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 01:33:57AM +0200, Adrian Bunk wrote:
> On Wed, Sep 06, 2006 at 03:54:44PM -0700, Greg KH wrote:
> > This is the start of the stable review cycle for next 2.6.17.y release.
> > There are 37 patches in this series, all will be posted as a response to
> > this one.  If anyone has any issues with these being applied, please let
> > us know.  If anyone is a maintainer of the proper subsystem, and wants
> > to add a Signed-off-by: line to the patch, please respond with it.
> > 
> > These patches are sent out with a number of different people on the Cc:
> > line.  If you wish to be a reviewer, please email stable@kernel.org to
> > add your name to the list.  If you want to be off the reviewer list,
> > also email us.
> > 
> > Responses should be made by Fri Sep 8 22:00:00 UTC.  Anything received
> > after that time might be too late.
> > 
> > Full patch of this whole series is available at:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.17.12-rc1.gz
> > if you wish to test it out and make sure nothing is broken on your
> > architecture or system.
> 
> The patch is reversed and doesn't update the Makefile.

Doh, I need to automate this portion instead of doing it by hand all the
time...

The patch is now updated (will take a few minutes to be mirrored),
thanks for pointing it out.

greg k-h
