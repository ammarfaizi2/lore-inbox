Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVIMWY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVIMWY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVIMWY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:24:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932507AbVIMWY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:24:57 -0400
Date: Tue, 13 Sep 2005 15:24:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: Linus Torvalds <torvalds@osdl.org>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
Message-ID: <20050913222418.GM7762@shell0.pdx.osdl.net>
References: <1126569577.25875.25.camel@defiant> <Pine.LNX.4.58.0509121950340.3266@g5.osdl.org> <20050913033814.GA879@tbdnetworks.com> <Pine.LNX.4.58.0509130717360.3351@g5.osdl.org> <1126631386.4555.13.camel@defiant> <Pine.LNX.4.58.0509131016110.3351@g5.osdl.org> <1126646605.4555.26.camel@defiant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126646605.4555.26.camel@defiant>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Norbert Kiesel (nkiesel@tbdnetworks.com) wrote:
> system is stable again (I'm way beyond the point where I got lockups
> before).  Thanks a bunch for the quick fix!  I'd recommend to include
> this patch in 2.6.13.2.

Thanks, it's already been added to the queue.
-chris
