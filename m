Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbULOSxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbULOSxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbULOSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:52:42 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:64128
	"HELO linuxace.com") by vger.kernel.org with SMTP id S262450AbULOSu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:50:26 -0500
Date: Wed, 15 Dec 2004 10:50:24 -0800
From: Phil Oester <kernel@linuxace.com>
To: Chris Wright <chrisw@osdl.org>
Cc: David Jacoby <dj@outpost24.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
Message-ID: <20041215185024.GA16990@linuxace.com>
References: <41BFF931.6030205@outpost24.com> <20041215.180839.93043538.yoshfuji@linux-ipv6.org> <41C024B0.4010009@outpost24.com> <200412151254.37612@WOLK> <41C0268B.2030708@outpost24.com> <20041215120418.GA9049@tufnell.lon1.poggs.net> <41C029F7.7010405@outpost24.com> <20041215103407.T469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215103407.T469@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 10:34:07AM -0800, Chris Wright wrote:
> * David Jacoby (dj@outpost24.com) wrote:
> > The patch fucked something up, sorry for my language. Is there anyone 
> > else on
> > this list who has the patch installed?
> 
> Patch is fine.  I've used it and ssh quite a bit.  It only touches small
> bit of multicast specific code which isn't used at all during ssh session.

Yes, user is moving from unpatched 2.4.24 -> patched 2.6.9, and likely has
a pty config issue...

Phil

