Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTAHQK5>; Wed, 8 Jan 2003 11:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTAHQK5>; Wed, 8 Jan 2003 11:10:57 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:48402
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267261AbTAHQK5>; Wed, 8 Jan 2003 11:10:57 -0500
Subject: Re: observations on 2.5 config screens
From: Robert Love <rml@tech9.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030108093021.21759B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030108093021.21759B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042041195.694.2734.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-3) 
Date: 08 Jan 2003 10:53:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 09:32, Bill Davidsen wrote:

> Someone else suggested putting all the low level options like preempt,
> smp, and the stuff in kernel-hacking into a single menu, with a better
> name.

I do not think I like this.  SMP, kernel preemption, and high memory
support are the three most fundamental choices one makes during
configuration.

They should be out in the open, in the beginning, in a well-labeled
category.  They only issue I see is "processor options" should be
renamed "core options" or whatever.  But that is trivial.

	Robert Love

