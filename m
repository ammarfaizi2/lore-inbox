Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbTICAUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 20:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTICAUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 20:20:17 -0400
Received: from mail.webmaster.com ([216.152.64.131]:23510 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261253AbTICAUN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 20:20:13 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Andre Hedrick" <andre@linux-ide.org>,
       "James Clark" <jimwclark@ntlworld.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Driver Model
Date: Tue, 2 Sep 2003 17:20:10 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAENJGCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.10.10309021555410.8229-100000@master.linux-ide.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I agree with you, except for the one place where you've contradicted
yourself:

> If you are an embedded space widget.  Apply thumb to nose and wiggle
> fingers.  Provided you ship the source code you modify in the kernel, and
> I do mean all of it, use the short cut to clobber the issues in module.h.
> When they scream and complain about, this violates intent, ask them are
> they issuing a restriction on the usage of the GPL kernel?  If they do not
> permit one to use it under GPL them the kernel itself is in violation.

	In other words, you cannot release something under the GPL and
simultaneously restrict its use.

> Now back to "tainting", if the politics were such to cause all modules
> which are not GPL to be rejected then the game is over.  Because the
> kernel does not reject loading, it by default approves of closed source
> binary modules.  One could use the means of taint-testing to accept or
> reject, regardless of the original intent.  Many have and will make the
> argument the kernel has the ability to reject closed source and it choose
> to accept.

	So no, the kernel does not have the ability to reject closed source. That
would be an additional restriction upon use that the GPL does not allow you
to impose.

	DS


