Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTECStr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTECStr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:49:47 -0400
Received: from rth.ninka.net ([216.101.162.244]:25065 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263373AbTECStq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:49:46 -0400
Subject: Re: [PATCH 2.5.68] mod_timer fix for dst.c
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1051950454.1243.21.camel@lima.royalchallenge.com>
References: <1051950454.1243.21.camel@lima.royalchallenge.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051952535.14504.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2003 02:02:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Post this to where it belongs, the linux-net and netdev
lists.

This is occuring far too frequently, and I'll be damned if I'm
going to be required to read each and every linux-kernel posting
to catch all of the networking patches.

Therefore, from now on I'm going to flat out ignore every
networking patch that is sent to lkml and isn't at least CC:'d to
linux-net, netdev, or the listed networking maintainers.  I mean
what the heck is the purpose of the MAINTAINERS entry if people
don't even use it?

-- 
David S. Miller <davem@redhat.com>
