Return-Path: <linux-kernel-owner+w=401wt.eu-S1752094AbWLONCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbWLONCF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 08:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbWLONCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 08:02:05 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42798 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbWLONCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 08:02:04 -0500
Date: Fri, 15 Dec 2006 08:00:21 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: tike64 <tike64@yahoo.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: realtime-preempt and arm
In-Reply-To: <20061215095814.GA29368@elte.hu>
Message-ID: <Pine.LNX.4.58.0612150758170.25130@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0612140928020.19074@gandalf.stny.rr.com>
 <20061215071541.35583.qmail@web59204.mail.re1.yahoo.com> <20061215095814.GA29368@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Dec 2006, Ingo Molnar wrote:

>
> so these results look pretty normal to me.

Ingo, Did you run this with high res turned off?  That will simulate his
scenerio more so.

> Modified code attached below.
> (Change the '#if 1' to '#if 0' to get the select() measurement.)

Your code is almost exactly what I did to test! :)

-- Steve

