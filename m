Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbTGHGvB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 02:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbTGHGvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 02:51:01 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:46228 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S266892AbTGHGu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 02:50:59 -0400
Subject: Re: JFFS2: many compile warnings with gcc 2.95 + kernel 2.5
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@fs.tum.de, jffs-dev@axis.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030707234910.3d9a9c60.akpm@osdl.org>
References: <20030708001937.GA6848@fs.tum.de>
	 <20030707180023.0877085e.akpm@osdl.org>
	 <1057646526.28965.4.camel@imladris.demon.co.uk>
	 <20030707234910.3d9a9c60.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1057647927.28965.7.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Tue, 08 Jul 2003 08:05:27 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: akpm@osdl.org, bunk@fs.tum.de, jffs-dev@axis.com, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-08 at 07:49, Andrew Morton wrote:
> We work around gcc problems all the time.  It is called "being practical".

It's purely cosmetic and ignoring the warnings is a perfectly sufficient
workaround. As is removing the attribute from the declaration. Please
don't change the code.

-- 
dwmw2


