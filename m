Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbTE0M3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTE0M3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:29:04 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:26045 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263445AbTE0M3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:29:03 -0400
Date: Tue, 27 May 2003 13:42:51 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jason Woodward <woodwardj@jaos.org>
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.70: drivers/video/i810/i810.h
Message-ID: <20030527124251.GA28799@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jason Woodward <woodwardj@jaos.org>, adaplas@pol.net,
	linux-kernel@vger.kernel.org
References: <mailbox-6776-1054039388@jaos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mailbox-6776-1054039388@jaos.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 08:43:08AM -0400, Jason Woodward wrote:
 > Here is a patch against 2.5.70 that fixes a compilation error for i810:

Already fixed in the agpgart bk tree. The pull request to Linus
got sent just a few minutes too late for 2.5.70.
There's also a fix there for the sis driver that has the same problem.

		Dave


