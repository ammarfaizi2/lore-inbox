Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbUJWV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUJWV13 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbUJWV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 17:27:28 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:11162 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261278AbUJWV10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 17:27:26 -0400
Subject: Re: The naming wars continue...
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098485798.6028.83.camel@gaston>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
	 <1098485798.6028.83.camel@gaston>
Content-Type: text/plain
Message-Id: <1098566710.3872.149.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 23 Oct 2004 22:25:10 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 08:56 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2004-10-23 at 08:05, Linus Torvalds wrote:
> 
> > So to not overtax my poor brain, I'll just call them all -rc releases, and
> > hope that developers see them as a sign that there's been stuff merged,
> > and we should start calming down and seeing to the merged patches being
> > stable soon enough..
> 
> Hehe, and a bunch of important (for me) ones that couldn't get in yet

Damn right. If 2.6.10 doesn't boot on the G5 with i8042 and 8250 drivers
built in, and doesn't sleep (well, more to the point doesn't resume) on
my shinybook, I shall sulk :)

-- 
dwmw2


