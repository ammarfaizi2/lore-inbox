Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUIWTlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUIWTlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIWTlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:41:18 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:34725 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268225AbUIWTlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:41:17 -0400
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
From: Albert Cahalan <albert@users.sf.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de,
       gandalf@wlug.westbo.se
In-Reply-To: <41532504.3000005@nortelnetworks.com>
References: <1095962839.4974.965.camel@cube>
	 <41532504.3000005@nortelnetworks.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095968193.4969.980.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Sep 2004 15:36:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 15:33, Chris Friesen wrote:
> Albert Cahalan wrote:
> 
> > Who is doing a 32-bit userland on x86-64, and WTF for?
> > Why do they not also run a 32-bit kernel?
> 
> Backwards compatibility?  Desire to run binary-only 32-bit software as well as 
> 64-bit software on the same kernel?

Nope. For that, you run 99% 64-bit, including iptables.
That's what is typically done. So you'd have a 32-bit
OpenOffice maybe, and everything else is 64-bit.

I'm still not seeing a need to run an x86-64 kernel
with an i386 iptables.


