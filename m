Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVBKQIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVBKQIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 11:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVBKQIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 11:08:46 -0500
Received: from styx.suse.cz ([82.119.242.94]:28141 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262263AbVBKQIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 11:08:45 -0500
Date: Fri, 11 Feb 2005 17:08:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Richard Koch <n1gp@hotmail.com>
Cc: vojtech@suse.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding the ICS MK712 touchscreen driver to 2.6
Message-ID: <20050211160846.GD2284@ucw.cz>
References: <BAY16-F19F98BAFC5D2AFD6CC88DB87770@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY16-F19F98BAFC5D2AFD6CC88DB87770@phx.gbl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 10:50:19AM -0500, Richard Koch wrote:

> Thanks for the evtest.c program and the information about evtouch. After the
> minor change from LONG(BTN_LEFT) to LONG(BTN_TOUCH), patch below, I
> was able to then get touch on/off events. Also I tested this driver with the
> "evtouch" Xwindows driver and it worked nicely.

Thanks a lot for testing and for the fix!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
