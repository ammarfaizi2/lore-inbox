Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTLIXsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTLIXsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:48:06 -0500
Received: from mail.webmaster.com ([216.152.64.131]:420 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263475AbTLIXr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:47:59 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Dale Whitchurch" <dalew@sealevel.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Tue, 9 Dec 2003 15:47:53 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCELIIJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1070979148.16262.63.camel@oktoberfest>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Is the GPL in effect for the kernel so that anybody can enhance the
> current drivers and add support for any other device?  If two companies
> develop competing products and those products (albeit a few slight
> differences) perform the same operations using almost the same hardware,
> do we want one company to use the others driver?

	Assuming all the drivers are offered under the GPL, the kernel inclusion
process is a meritocracy. In other words, good code gets added and bad code
doesn't.

	The GPL provides unrestricted joinder and severance, so if the driver is
GPL and the kernel is GPL, anyone who wants to can join them together under
the GPL can do so. Linus would likely do this officially if the driver is
reasonable, and anyone who cares enough can do the work needed to get it
suitable for inclusion if the original company that offered the driver
doesn't want to.

	DS


