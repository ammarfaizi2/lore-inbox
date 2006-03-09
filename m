Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWCIWVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWCIWVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWCIWVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:21:33 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:40712 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751764AbWCIWVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:21:33 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Phillip Susi" <psusi@cfl.rr.com>, <mr.fred.smoothie@pobox.com>
Cc: "Luke-Jr" <luke@dashjr.org>, "Anshuman Gholap" <anshu.pg@gmail.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [future of drivers?] a proposal for binary drivers.
Date: Thu, 9 Mar 2006 14:21:00 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEPKKJAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 09 Mar 2006 14:17:20 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 09 Mar 2006 14:17:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There are no dearth of legal opinions on this matter which differ
> quite radically from your interpretation here, quite a few from
> lawyers. As far as I am concerned (and the GPL too, if my
> interpretation of it is correct), any code is a derived work of my
> code if either a) it directly makes use of symbols in my code or b) it
> cannot execute unless my code executes, such that its distribution
> without my code would be useless.

	You are claiming that you have copyright over *any* code that *does* X.
This is the one specific thing that copyright can *never* give you. You can
only hold copyright over something if there are a large number of ways to do
the *same* *thing*, and you creatively picked one of them.

	Yes, they can use some code other than your code, just as Static Controls
could have used some printers other than Lexmark's printers. See Lexmark v.
Static Controls.

	But you cannot say you own every way to make X do Y. If there is only one
practically possible way to do X, then nobody can hold copyright on it, even
if there are many ways to do Y, and Y is similar to X. It must be the same.
That's the law, and it makes a lot of sense.

	If you want to own *any* way to make X do Y with Z, then you need a
software patent. Copyrights only cover your choice of one of the many
possible ways to make X do Y with Z.

	DS


