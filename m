Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWEOFnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWEOFnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 01:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWEOFnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 01:43:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:54488 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932169AbWEOFnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 01:43:22 -0400
X-Authenticated: #14349625
Subject: Re: rt20 scheduling latency testcase and failure data
From: Mike Galbraith <efault@gmx.de>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <200605131106.16864.dvhltc@us.ibm.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <20060513112039.41536fb5@mango.fruits>
	 <200605131106.16864.dvhltc@us.ibm.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 07:43:41 +0200
Message-Id: <1147671821.7633.13.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:

> I haven't yet tried running with the RT Latency / Trace tools.  I can try 
> those if folks they think they will be useful.

FWIW, enabling tracing made the 10ms failure variant fairly repeatable
here.

	-Mike

