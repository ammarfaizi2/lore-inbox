Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTLDCAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 21:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTLDCAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 21:00:42 -0500
Received: from c06284a.rny.bostream.se ([217.215.27.171]:14094 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S263053AbTLDCAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 21:00:41 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16334.38227.433336.514399@pc7.dolda2000.com>
Date: Thu, 4 Dec 2003 03:00:51 +0100
To: Greg KH <greg@kroah.com>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is hotplug a kernel helper?
In-Reply-To: <20031204011357.GA22506@kroah.com>
References: <16334.31260.278243.22272@pc7.dolda2000.com>
	<20031204011357.GA22506@kroah.com>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > On Thu, Dec 04, 2003 at 01:04:44AM +0100, Fredrik Tolf wrote:
 > > If you don't mind me asking, I would like to know why the kernel calls
 > > a usermode helper for hotplug events? Wouldn't a chrdev be a better
 > > solution (especially considering that programs like magicdev could
 > > listen in to it as well)? 
 > 
 > Please see the archives for why this is, it's been argued many times.

I am sincerely sorry for being a bother, but I have spent several
hours searching far and wide for information on it, both in the
archives and generally on the web, without any luck in finding
anything. If it's not too much to ask, would you be as kind as to
provide a pointer?

Btw., Is there any preferred method of announcing hotplug events to
user interfaces?

Fredrik Tolf

