Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTITPsw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 11:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbTITPsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 11:48:52 -0400
Received: from rdu168-183-242.nc.rr.com ([24.168.183.242]:50406 "EHLO
	salusa.ix.dyndns.org") by vger.kernel.org with ESMTP
	id S261907AbTITPsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 11:48:51 -0400
Subject: Re: PCI/ACPI related boot hang with 2.6.0-test5-bk3 on KT266A mobo
From: Jeff Layton <jtlayton@poochiereds.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030919162937.B16516@osdlab.pdx.osdl.net>
References: <1063982354.17540.173.camel@tesla.mmt.bellhowell.com>
	 <20030919162937.B16516@osdlab.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1064072927.1203.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 20 Sep 2003 11:48:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I couldn't get the patch to apply cleanly, so I applied it by hand. It
does seem to fix the problem in test5-bk7. Many thanks!
-- Jeff

On Fri, 2003-09-19 at 19:29, Chris Wright wrote:
> * Jeffrey Layton (jtlayton@poochiereds.net) wrote:
> > 
> > I'll happily provide more info or test patches for this if you can tell
> 
> Does this patch fix it for you?
> thanks,
> -chris
-- 
Jeff Layton <jtlayton@poochiereds.net>

