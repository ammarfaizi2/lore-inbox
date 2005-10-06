Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVJFKnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVJFKnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVJFKnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:43:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48326 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750812AbVJFKnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:43:20 -0400
Date: Thu, 6 Oct 2005 12:42:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051006104247.GA25255@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz> <200510051020.15400.rjw@sisk.pl> <20051005083341.GA22034@elf.ucw.cz> <200510061023.16016.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510061023.16016.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > OK, but if we decide to move some functions from one file to another,
> > > we'll have to wait for another "settle down" period, I think.
> > 
> > Yes...
> 
> Then I'd propose that we wait for the next "settle down" period with the
> split and apply all of the bugfixes and cleanups now.

Nigel's cleanup is not ready yet, and yours is oneliner. I applied
that oneliner locally. I already have cleanups depending on the
split. Of course I can redo them, but perhaps it is easier to just
redo that one line.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
