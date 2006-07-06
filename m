Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWGFMcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWGFMcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWGFMcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:32:14 -0400
Received: from www.osadl.org ([213.239.205.134]:18052 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030228AbWGFMcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:32:13 -0400
Subject: Re: New PriorityInheritanceTest - bug in 2.6.17-rt7 confirmed
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <Pine.LNX.4.64.0607061307260.10454@localhost.localdomain>
References: <Pine.LNX.4.64.0607061307260.10454@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 14:34:52 +0200
Message-Id: <1152189293.24611.146.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 14:07 +0100, Esben Nielsen wrote:
> So this is a real bug.

True

> In the previous mail I posted a fix for that problem (and other problems).

I had not much time to look at the patch, but I doubt that we need such
a complex hack to achieve that. I will look at it later.

	tglx


