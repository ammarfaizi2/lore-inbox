Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVLIPTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVLIPTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVLIPTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:19:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:5329 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932219AbVLIPTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:19:16 -0500
Date: Fri, 9 Dec 2005 16:19:14 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209151914.GA26653@suse.de>
References: <20051209140559.GA23868@suse.de> <20051209151348.GA12815@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051209151348.GA12815@nevyn.them.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Dec 09, Daniel Jacobowitz wrote:

> And... you're going to make it impossible to run ppp over the serial
> console port.  For everyone, not just your big POWER4 boxes.  As far as
> I know, if you turn off the printk log level, this should work just
> fine today.

Can one send break (via ppp) in this setup?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
