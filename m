Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263364AbUDWBA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUDWBA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 21:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUDWBA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 21:00:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:36030 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263364AbUDWBA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 21:00:26 -0400
Subject: Re: New Radeonfb (2.6.5) driver does not play nice with X (4.3.0)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Lamanna <jamesl@appliedminds.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4087EB5A.7040404@appliedminds.com>
References: <4087EB5A.7040404@appliedminds.com>
Content-Type: text/plain
Message-Id: <1082681913.2056.143.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 10:58:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-23 at 01:57, James Lamanna wrote:
> I'm having some serious issues with the "new" radeonfb driver.
> The system boots up fine, but as soon as I start X windows,
> I cannot switch to a virtual console.
> 
> If I do, the screen goes black with what looks like lines of really
> tiny, squashed text? maybe, and the system totally hangs.
> No keyboard input, can't ssh in, totally dead.

It works with XFree driver, but there are problems with ATI binary
one. Difficult to say what's up at this point precisely as I don't
have an x86 setup to reproduce the problem.

Ben.


