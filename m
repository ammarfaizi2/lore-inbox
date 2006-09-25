Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWIYBkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWIYBkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWIYBkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:40:23 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:12552 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S932212AbWIYBkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:40:22 -0400
Date: Mon, 25 Sep 2006 11:42:05 +1000
From: CaT <cat@zip.com.au>
To: sleon@sleon.dyndns.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: megaraid question
Message-ID: <20060925014205.GT2007@zip.com.au>
References: <20060925012909.A56E52963F@sleon.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925012909.A56E52963F@sleon.dyndns.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 01:29:09AM +0000, sleon@sleon.dyndns.org wrote:
> i am using opensource megaraid driver (2.6.17) . Do you know any
> opensource monitoring tool for the opensource megaraid drivers Or is
> there a way to check the state of harddrives connected to the megaraid
> controller?

I've only found MegaCLI which has the kind of interface that makes
me wish I was a bricklayer (I'm looking at the SAS raid card btw).

Pick your card out from http://www.lsilogic.com/cm/DownloadSearch.do
and you should get something. No source (fooey) but at least it's
something.

Wish the source was available though. I might be bothered to do
something about the interface.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
