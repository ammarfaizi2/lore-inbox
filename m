Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUGISRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUGISRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUGISRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:17:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:9671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265200AbUGISRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:17:19 -0400
Date: Fri, 9 Jul 2004 11:17:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Chris Wright <chrisw@osdl.org>, Chris White <webmaster@securesystem.info>,
       manuel@todo-linux.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel fchown() exploit status?
Message-ID: <20040709111717.J1973@build.pdx.osdl.net>
References: <40EDB764.6060107@securesystem.info> <20040708162414.I1973@build.pdx.osdl.net> <200407091146.32077.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200407091146.32077.mbuesch@freenet.de>; from mbuesch@freenet.de on Fri, Jul 09, 2004 at 11:46:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch (mbuesch@freenet.de) wrote:
> Is there an exploit available to test if the kernel has
> this vulnerability?

Just use of chown(2).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
