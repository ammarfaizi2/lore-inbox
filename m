Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbUCXP7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263757AbUCXP7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:59:00 -0500
Received: from main.gmane.org ([80.91.224.249]:13199 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263754AbUCXP66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:58:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Edd Dumbill <edd@usefulinc.com>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
	instead of apic ack delay.
Date: Wed, 24 Mar 2004 15:59:13 +0000
Message-ID: <1080143953.15381.61.camel@saag>
References: <200402120122.06362.ross@datscreative.com.au>
	 <200402141124.50880.ross@datscreative.com.au> <40395961.40608@gmx.de>
	  <200402252238.55834.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: starway.heddley.com
In-Reply-To: <200402252238.55834.ross@datscreative.com.au>
X-Mailer: Ximian Evolution 1.5.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 22:38 +1000, Ross Dickson wrote:
> Patches attached rediffed for 2.6.3 and 2.6.3-mm3.

I've been running the idleC1halt patch against 2.6.3 and 2.6.4 for some
time and have had no crashes and no clock skew.  A7N8X Delux mobo, AMD
Athlon XP 3000+.

Thanks for your work.

-- Edd



