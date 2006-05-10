Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWEJOnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWEJOnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWEJOnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:43:42 -0400
Received: from [63.81.120.158] ([63.81.120.158]:14970 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751456AbWEJOnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:43:42 -0400
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0605100453540.556@gandalf.stny.rr.com>
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
	 <20060510053701.GO3570@stusta.de>
	 <Pine.LNX.4.58.0605100453540.556@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 07:43:40 -0700
Message-Id: <1147272220.21536.77.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 05:00 -0400, Steven Rostedt wrote:

> Perfect example of what Andrew Morten stated in his keynote at LinuxTag.
> He mentioned patches that fixed warnings but not the problem that they
> warn about.  He stated that these are very dangerous, because, not only is
> the problem not fixed, but now no one knows of the problem.

This is the third time I've had to remind people that this email is a
bug report .. It's not a fix for anything , I even said as much in my
initial email.  (Also notice Andrew isn't CC'd on this one..)

Daniel

