Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTLEBDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTLEBDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:03:50 -0500
Received: from codepoet.org ([166.70.99.138]:50923 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263772AbTLEBDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:03:49 -0500
Date: Thu, 4 Dec 2003 18:03:49 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031205010349.GA9745@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 04, 2003 at 07:58:18PM -0500, Zwane Mwaikambo wrote:
> What about software which utilises Linux specific kernel
> services, such as say some cd writing software?

An ordinary program that uses normal system calls?

linux/COPYING says: This copyright does *not* cover user programs
that use kernel services by normal system calls - this is merely
considered normal use of the kernel, and does *not* fall under
the heading of "derived work".

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
