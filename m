Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVAMI7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVAMI7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVAMI7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:59:08 -0500
Received: from mail.enyo.de ([212.9.189.167]:11396 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261200AbVAMI7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:59:02 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
References: <20050112094807.K24171@build.pdx.osdl.net>
	<Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	<20050112185133.GA10687@kroah.com>
	<Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	<20050112161227.GF32024@logos.cnet>
	<Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	<20050112205350.GM24518@redhat.com>
	<Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	<20050113032506.GB1212@redhat.com>
	<20050113035331.GC9176@beowulf.thanes.org>
	<20050113053807.GE4378@ip68-4-98-123.oc.oc.cox.net>
Date: Thu, 13 Jan 2005 09:59:00 +0100
In-Reply-To: <20050113053807.GE4378@ip68-4-98-123.oc.oc.cox.net> (Barry
	K. Nathan's message of "Wed, 12 Jan 2005 21:38:07 -0800")
Message-ID: <878y6xr9gr.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Barry K. Nathan:

> On Thu, Jan 13, 2005 at 04:53:31AM +0100, Marek Habersack wrote:
>> archived mail message or a webpage with the patch. Hoping he'll find the
>> fixes in the vendor kernels, he goes to download source packages from SuSe,
>> RedHat or Trustix, Debian, Ubuntu, whatever and discovers that it is as easy
>> to find the patch there as it is to fish it out of the vanilla kernel patch
>> for the new version. Frustrating, isn't it? Not to mention that he might
>
> http://linux.bkbits.net is your friend.
>
> Each patch (including security fixes) in the mainline kernels (2.4 and
> 2.6) appears there as an individual, clickable link with a description
> (e.g. "1.1551  Paul Starzetz: sys_uselib() race vulnerability
> (CAN-2004-1235)").

This is the exception.  Usually, changelogs are cryptic, often
deliberately so.  Do you still remember Alan's DMCA protest
changelogs?
