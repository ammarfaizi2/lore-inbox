Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269000AbUIQQCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269000AbUIQQCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUIQP5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:57:38 -0400
Received: from peabody.ximian.com ([130.57.169.10]:16339 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268998AbUIQP4o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:56:44 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Robert Love <rml@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095432696.26146.15.camel@localhost.localdomain>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
	 <1095376979.23385.176.camel@betsy.boston.ximian.com>
	 <1095377752.23913.3.camel@localhost.localdomain>
	 <1095388176.20763.29.camel@localhost>
	 <1095431960.26147.13.camel@localhost.localdomain>
	 <1095436123.23385.182.camel@betsy.boston.ximian.com>
	 <1095432696.26146.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 17 Sep 2004 11:55:41 -0400
Message-Id: <1095436541.23385.183.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 15:51 +0100, Alan Cox wrote:

> For the file change case I'm unconvinced, although it looks like it
> could be done with the security module hooks and without kernel mods
> beyond that.

Everyone keeps telling me this.  I am unconvinced, too. ;-)

It should get more attention, though..

	Robert Love


