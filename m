Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVL3A4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVL3A4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 19:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVL3A4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 19:56:23 -0500
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:41160 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1751180AbVL3A4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 19:56:22 -0500
Date: Thu, 29 Dec 2005 19:56:15 -0500 (EST)
From: Dan Streetman <ddstreet@ieee.org>
Reply-To: ddstreet@ieee.org
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, Bodo Eggert <7eggert@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: EHCI TT bandwidth (was Re: [PATCH] USB_BANDWIDTH documentation
 change)
In-Reply-To: <200512291212.46348.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.51.0512291953410.27412@dylan.root.cx>
References: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
 <200512270857.35505.david-b@pacbell.net> <Pine.LNX.4.51.0512291433090.27091@dylan.root.cx>
 <200512291212.46348.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELNK-Trace: a4c357c9134943511aa676d7e74259b7b3291a7d08dfec79aca18b4c87922b4bfacff7daeb6baa0a350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.148.162.106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Dec 2005, David Brownell wrote:

>Though I did notice you were using microframe "7" as an error code;
>best to have some #defined constant, and one that would later allow
>for use of FSTN nodes in the periodic schedule.

Sounds good, feel free to make any changes you want of course :)
or if you have other comments and/or want me to resend the patches let me 
know.


-- 
Dan Streetman
ddstreet@ieee.org
---------------------
186,272 miles per second:
It isn't just a good idea, it's the law!
