Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTJQRqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTJQRqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:46:19 -0400
Received: from devil.servak.biz ([209.124.81.2]:30416 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S263573AbTJQRqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:46:09 -0400
Subject: Re: [Linux-fbdev-devel] FBDEV 2.6.0-test7 updates.
From: Torrey Hoffman <thoffman@arnor.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310171824190.966-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0310171824190.966-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1066412752.1675.20.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 10:45:52 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-17 at 10:25, James Simmons wrote:
[...]

> The BK tree doesn't have the new radeon driver. I placed the new radeon 
> driver into the patch so people coudl test it.

I have a Radeon All-In-Wonder 7500.  I downloaded the tar.gz patch and
applied it to -test7.  The resulting kernel panics at startup, while
test7 with the same config works fine for me.

Before it panics, the penguin shows up at least, so it works a little
bit :-/

I have not had time to attach a serial console to capture the oops yet,
but hope to do that by the end of the day...


-- 
Torrey Hoffman <thoffman@arnor.net>

