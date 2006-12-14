Return-Path: <linux-kernel-owner+w=401wt.eu-S1751802AbWLNFrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbWLNFrJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 00:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWLNFrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 00:47:09 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:48763 "EHLO
	agminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbWLNFrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 00:47:08 -0500
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 00:47:08 EST
Date: Wed, 13 Dec 2006 21:41:40 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: sergio@sergiomb.no-ip.org, bjlockie@lockie.ca
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: escape key]
Message-Id: <20061213214140.df6111f5.randy.dunlap@oracle.com>
In-Reply-To: <1166058290.2964.15.camel@monteirov>
References: <1166058290.2964.15.camel@monteirov>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 01:04:50 +0000 Sergio Monteiro Basto wrote:

> -------- Forwarded Message --------
> > From: James Lockie <bjlockie@lockie.ca>
> > To: linux-x86_64@vger.kernel.org
> > Subject: escape key
> > Date: 	Tue, 12 Dec 2006 14:57:57 -0500
> > 
> > I can't use the escape key to exit a menu with make menuconfig on 
> > kernel-2.6.19 or .1
> > It works on 2.6.18. :-(

Is this a problem?

You can exit a menu by selecting <Exit> and pressing Enter
or (as the help text at the top of the screen says:)
pressing <Esc><Esc> (2 times).  Yes, pressing <Esc> one time
and then waiting for 1-2 seconds used to exit a menu.

One could argue that it has been "fixed" to match the help text.

---
~Randy
