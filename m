Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUKETDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUKETDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUKETDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:03:39 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:6668 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261160AbUKETDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:03:37 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <adam@yggdrasil.com>, <jp@enix.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Possible GPL infringement in Broadcom-based routers
Date: Fri, 5 Nov 2004 11:03:22 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEBPPJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <200411061040.iA6AeZp03452@freya.yggdrasil.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 05 Nov 2004 10:39:55 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 05 Nov 2004 10:39:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	I think you're missing the idea that that such drivers are
> _contributory_ infringement to the direct infringement that occurs when
> the user loads the module.

	Except that loading the module is not infringement. The GPL does not
restrict use of GPL'd code in any way.

> In other words, even for a driver that has
> not a byte of code derived from the kernel, if all its uses involve it
> being loaded into a GPL'ed kernel to form an infringing derivative
> work in RAM by the user committing direct copyright infringement against
> numerous GPL'ed kernel components, then it fails the test of having
> a substantial non-infringing use, as established in the Betamax decision,
> and distributing it is contributory infringement of those GPL'ed
> components of the kernel.

	In order for there to be an "infringing derivative work", some clause of
the GPL would have to be infringed. There exists no clause in the GPL that
restricts the *creation* of derivative works that are not distributed.

	If your argument were correct, then no non-GPL'd software could *ever* be
distributed for Linux. You see, loading that software would create an
"infringing derivative work" in the memory of the computer running it,
combining the Linux kernel with the software.

	DS


