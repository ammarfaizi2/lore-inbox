Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268347AbUHXVew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268347AbUHXVew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbUHXVew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:34:52 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42965 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S268354AbUHXVai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:30:38 -0400
Date: Tue, 24 Aug 2004 14:30:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg Weeks <greg.weeks@timesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: [patch] ppc ep8260 support under 2.6.6
Message-ID: <20040824213035.GH4521@smtp.west.cox.net>
References: <412B638E.80500@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412B638E.80500@timesys.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 11:49:34AM -0400, Greg Weeks wrote:

> This is basic support for the Embedded Planet's ep8260 board. It doesn't 
> include MTD support. This patch unfortunatly doesn't apply to 2.6.8 just 
> to 2.6.6. The code isn't mine, though it was developed here at Timesys. 
> I just needed it running under 2.6.6.
> 
> Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0057

Note the reason it doesn't apply is that ep8260 (rpx8260) went into
2.6.8. :)

If you have access to the board, could you give it a shot in the
linuxppc-2.5 tree?  There's fcc changes in there that I'd like to get
tested on a few more boards before I push them out (or the driver gets
obsoleted).

-- 
Tom Rini
http://gate.crashing.org/~trini/
