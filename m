Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVAKBWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVAKBWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAKBV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:21:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:28581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262604AbVAKBSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:18:31 -0500
Date: Mon, 10 Jan 2005 17:18:26 -0800
From: Chris Wright <chrisw@osdl.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, juhl-lkml@dif.dk, steve@rueb.com,
       linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
Message-ID: <20050110171826.L2357@build.pdx.osdl.net>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de> <41E2F6B3.9060008@rueb.com> <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost> <20050110164001.Q469@build.pdx.osdl.net> <20050111020931.3acbf4b9.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050111020931.3acbf4b9.diegocg@gmail.com>; from diegocg@gmail.com on Tue, Jan 11, 2005 at 02:09:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Diego Calleja (diegocg@gmail.com) wrote:
> El Mon, 10 Jan 2005 16:40:02 -0800 Chris Wright <chrisw@osdl.org> escribió:
> 
> > Problem is, the rest of the world uses a security contact for reporting
> > security sensitive bugs to project maintainers and coordinating
> > disclosures.  I think it would be good for the kernel to do that as well.
> 
> (somewhat OT..)
> 
> Perhaps it's just me, but i think it'd be nice that a new kernel version is
> released every time a security issue is found.

I agree.  I'd not mind seeing a full release, but at least a collection
of relevant patches.  I used to keep such a list, and have discussed
bringing it back with some folks (just for the current stable 2.6.x).
I think there's some agreement that we could do better.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
