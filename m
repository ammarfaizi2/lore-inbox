Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSGEJOG>; Fri, 5 Jul 2002 05:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSGEJOF>; Fri, 5 Jul 2002 05:14:05 -0400
Received: from holomorphy.com ([66.224.33.161]:1261 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316163AbSGEJOE>;
	Fri, 5 Jul 2002 05:14:04 -0400
Date: Fri, 5 Jul 2002 02:12:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Davidsen <davidsen@tmr.com>, Rob Landley <landley@trommello.org>,
       Tom Rini <trini@kernel.crashing.org>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
Message-ID: <20020705091227.GS22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Bill Davidsen <davidsen@tmr.com>,
	Rob Landley <landley@trommello.org>,
	Tom Rini <trini@kernel.crashing.org>,
	"J.A. Magallon" <jamagallon@able.es>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020703232322.2248C-100000@gatekeeper.tmr.com> <Pine.LNX.4.44.0207040846340.3309-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207040846340.3309-100000@e2>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 08:56:01AM +0200, Ingo Molnar wrote:
> are these hard numbers? I havent seen much hard data yet from real-life
> servers using the O(1) scheduler. There was lots of feedback from
> desktop-class systems that behave better, but servers used to be pretty
> good with the previous scheduler as well.

I seem to recall some testing having been done demonstrating such
differences. I'll ask around when I get back from vacation, though I'll
confess it's far afield from my usual interests.


Cheers,
Bill
