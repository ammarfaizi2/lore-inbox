Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVGZCpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVGZCpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVGZCpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:45:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4277 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261606AbVGZCpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:45:46 -0400
Subject: Re: [patch 2.6.13-rc3] i386: clean up user_mode macros
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
In-Reply-To: <1122337212.4895.7.camel@localhost.localdomain>
References: <200507251901_MC3-1-A589-A433@compuserve.com>
	 <Pine.LNX.4.58.0507251608430.6074@g5.osdl.org>
	 <1122337212.4895.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 22:45:41 -0400
Message-Id: <1122345942.1472.81.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 20:20 -0400, Steven Rostedt wrote:
> And I
> would also assume that you prefer x *= 2 over x <<= 1 (also since the
> first person to show this example used x <<= 2. Right Lee? :-)

Let us never speak of that again.  These aren't the droids you're
looking for.

Lee

