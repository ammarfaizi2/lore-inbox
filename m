Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWHGCTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWHGCTA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWHGCTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:19:00 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:28534 "EHLO
	asav14.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750897AbWHGCS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:18:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAMg+1kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.18-rc3-mm2
Date: Sun, 6 Aug 2006 22:18:58 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608070042.10485.rjw@sisk.pl>
In-Reply-To: <200608070042.10485.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608062218.58425.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 August 2006 18:42, Rafael J. Wysocki wrote:
> On Sunday 06 August 2006 12:08, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> 
> My box's (Asus L5D, x86_64) keyboard doesn't work on this kernel at all, even
> if I boot with init=/bin/bash.  On the 2.6.18-rc2-mm1 it worked.
> 
> Unfortunately I have no indication what can be wrong, no oopses, no error
> messages in dmesg, nothing.
> 
> Right now I'm doing a binary search for the offending patch.
> 

Can I please have dmesg with i8042.debug=1?

-- 
Dmitry
