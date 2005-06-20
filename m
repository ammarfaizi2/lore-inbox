Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVFTTYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVFTTYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFTTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:22:51 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:18052 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261523AbVFTTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:21:31 -0400
Date: Mon, 20 Jun 2005 12:21:18 -0700
From: Greg KH <gregkh@suse.de>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050620192118.GA13586@suse.de>
References: <200506181332.25287.nick@linicks.net> <42B6FBC7.5000900@pobox.com> <20050620173411.GB15212@suse.de> <200506202000.08114.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506202000.08114.nick@linicks.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 08:00:08PM +0100, Nick Warne wrote:
> On Monday 20 June 2005 18:34, you wrote:
> 
> > As for working with people's boxes, only the very oldest versions of
> > udev (like the reported 030 version which is a year old and I do not
> > think shipped by any distro) would have the "lockup" issue.  On all of
> > the other ones, only custom rules written by users would have issues
> > (meaning, not work).  I do not know of any shipping, supported distro
> > that currently has a boot lockup issue (if so, please let me know.)
> 
> It appears the issue people are seeing is with Slack 10, which shipped with 
> udev 0.26 - and I presume there was 'custom' rules Patrick had built in.

Ick.  Hm, there's not been any updates for slack since then? (note,
there was no 0.26 release, there are no '.' in udev releases.)

Any Slackware users want to pester them for updates?

thanks,

greg k-h
