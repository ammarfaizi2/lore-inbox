Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbULOSeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbULOSeM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbULOSeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:34:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:6884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262432AbULOSeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:34:08 -0500
Date: Wed, 15 Dec 2004 10:34:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: David Jacoby <dj@outpost24.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
Message-ID: <20041215103407.T469@build.pdx.osdl.net>
References: <41BFF931.6030205@outpost24.com> <20041215.180839.93043538.yoshfuji@linux-ipv6.org> <41C024B0.4010009@outpost24.com> <200412151254.37612@WOLK> <41C0268B.2030708@outpost24.com> <20041215120418.GA9049@tufnell.lon1.poggs.net> <41C029F7.7010405@outpost24.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41C029F7.7010405@outpost24.com>; from dj@outpost24.com on Wed, Dec 15, 2004 at 01:11:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Jacoby (dj@outpost24.com) wrote:
> The patch fucked something up, sorry for my language. Is there anyone 
> else on
> this list who has the patch installed?

Patch is fine.  I've used it and ssh quite a bit.  It only touches small
bit of multicast specific code which isn't used at all during ssh session.

thanks,
-chris
