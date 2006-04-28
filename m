Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWD1SWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWD1SWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWD1SWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:22:40 -0400
Received: from canuck.infradead.org ([205.233.218.70]:41890 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751790AbWD1SWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:22:39 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de, sam@ravnborg.org
In-Reply-To: <200604281413.05335.rob@landley.net>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <200604281413.05335.rob@landley.net>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 19:22:33 +0100
Message-Id: <1146248553.11909.559.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 14:13 -0400, Rob Landley wrote:
> I'd like to test this out.  Is there an easy way for a non-git-user to
> get a patch against a known -linus release via the above web
> interface?

In the general case, not really. Just install git.

There's a 'combined' tree containing both hdrcleanup-2.6 and
hdrinstall-2.6 tree at git://git.infradead.org/headers-2.6

I have just taken a diff of that and put it at
http://david.woodhou.se/headers-diff.patch but in general that won't be
up to date.

It should also be in the next -mm tree too.

-- 
dwmw2

