Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUHIU4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUHIU4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHIU4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:56:21 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:24612 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267184AbUHIUcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:32:04 -0400
Date: Mon, 9 Aug 2004 22:33:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org, zippel@linux-m68k.org
Subject: Re: [PATCH] save kernel version in .config file
Message-ID: <20040809203352.GA19748@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
	sam@ravnborg.org, zippel@linux-m68k.org
References: <20040803225753.15220897.rddunlap@osdl.org> <4117D88E.6080801@tmr.com> <20040809130554.0405f7e5.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809130554.0405f7e5.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 01:05:54PM -0700, Randy.Dunlap wrote:
> 
> OK, I'll change the description (above):
> 
> Tested with 'make {menuconfig|xconfig|gconfig|oldconfig}'.
> 
> In fact, what I posted in the email ('#' above) was from oldconfig.

I have the patch in my local tree - but due to a few pending issues I
not pushed it to linux-sam.bkbits.net/kbuild yet.
Will do so until next -mm

	Sam
