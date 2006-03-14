Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWCNAAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWCNAAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWCNAAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:00:24 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:32517 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751538AbWCNAAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:00:23 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Anshuman Gholap" <anshu.pg@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, "Jan Knutar" <jk-lkml@sci.fi>
Subject: RE: [future of drivers?] a proposal for binary drivers.
Date: Mon, 13 Mar 2006 16:00:11 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEBLKLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1142291208.8407.46.camel@gimli.at.home>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 13 Mar 2006 15:56:41 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 13 Mar 2006 15:56:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The consequence would be that $COMPANY writes a driver and blames the
> rest of the Linux world to change some internal undocumented interface
> months lateron just that they can commercially state to "support Linux"
> but without any real reason. In the non-evolutionary Windows world this
> holds until the next major release, but not on the high-tech front.

	It should be possible to define a reasonable set of requirements that one
must meet in order to claim to "support Linux", just as Microsoft does for
Windows. One requirement should definitely be that driver source code be
available to everyone who purchases the hardware and that all (or at least
sufficient) interfaces to the hardware be well-documented.

	DS


