Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265460AbTFMS0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265475AbTFMS0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:26:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10226 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265460AbTFMS0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:26:23 -0400
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
From: Robert Love <rml@tech9.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030613181516.GT828@ip68-0-152-218.tc.ph.cox.net>
References: <E19Qeoz-0004CM-00@calista.inka.de>
	 <3EE9DA08.2020707@nortelnetworks.com>
	 <20030613160335.GO828@ip68-0-152-218.tc.ph.cox.net>
	 <1055527639.662.364.camel@localhost>
	 <20030613181516.GT828@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1055529716.1123.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 13 Jun 2003 18:41:56 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 18:15, Tom Rini wrote:

> But how much have you rebuilt, heavily tested, etc?  I know that
> currently Debian/sid is building XFree86 4.1 at -O on all arches due to
> gcc-3.3 issues (some xdm auth problem on ppc and x86, other things
> elsewhere).

I believe Red Hat Rawhide (what I am running) is built with gcc 3.3.

Anyhow, my point was we _don't_ know if its ready so we cannot start
doing things which are detrimental to users of earlier kernels. I was
just adding that it does seem to compile the kernel fine for me, at
least.

	Robert Love

