Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVALTsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVALTsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVALTpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:45:24 -0500
Received: from mail.enyo.de ([212.9.189.167]:1514 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261332AbVALTla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:41:30 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
References: <20050112094807.K24171@build.pdx.osdl.net>
	<Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	<20050112185133.GA10687@kroah.com>
	<Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	<20050112191814.GA11042@kroah.com>
Date: Wed, 12 Jan 2005 20:41:23 +0100
In-Reply-To: <20050112191814.GA11042@kroah.com> (Greg KH's message of "Wed, 12
	Jan 2005 11:18:14 -0800")
Message-ID: <87sm56e8po.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH:

>> In other words, if you allow embargoes and vendor politics, what would the 
>> new list buy that isn't already in vendor-sec.
>
> vendor-sec handles a lot of other stuff that is not kernel related
> (every package that is in a distro.) This would only be for the kernel.

I don't know that much about vendor-sec, but wouldn't the kernel list
contain roughly the same set of people?  vendor-sec also has people
from the *BSDs, I believe, but they should probably notified of Linux
issues as well (often, similar mistakes are made in different
implementations).

If the readership is the same, it doesn't make sense to run two lists,
especially because it's not a normal list and you have to be capable
to deal with the vetting.

I agree that embargoed lists are nasty, but sometimes, you have to
make personal sacrifices to further the cause. 8-(
