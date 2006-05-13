Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWEMSVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWEMSVP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 14:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWEMSVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 14:21:15 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:33502 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932488AbWEMSVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 14:21:14 -0400
Subject: Re: rt20 scheduling latency testcase and failure data
From: Lee Revell <rlrevell@joe-job.com>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <200605131106.16864.dvhltc@us.ibm.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <20060513112039.41536fb5@mango.fruits>
	 <200605131106.16864.dvhltc@us.ibm.com>
Content-Type: text/plain
Date: Sat, 13 May 2006 14:21:11 -0400
Message-Id: <1147544472.6535.294.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:
>      1 [softirq-timer/0]

What happens if you set the softirq-timer threads to 99?

Lee

