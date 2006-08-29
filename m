Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWH2N5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWH2N5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWH2N5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:57:48 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:60170 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751427AbWH2N5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:57:47 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Possible gpl problem?
Date: Tue, 29 Aug 2006 06:57:40 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEEDOBAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1156763478.5340.70.camel@pmac.infradead.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 29 Aug 2006 06:52:35 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 29 Aug 2006 06:52:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2. If you ever distribute binaries _without_ source code, then you're
> obliged to make the source code available to _any_ third party on
> request; _not_ only those to whom you gave the binaries.

	That's not what the GPL says. The only clauses I think you could be talking
about are:

    b) You must cause any work that you distribute or publish, that in
    whole or in part contains or is derived from the Program or any
    part thereof, to be licensed as a whole at no charge to all third
    parties under the terms of this License.

	Note that providing a license does not require providing media. A license
is a right to use, not an ability to use or a copy of the covered work. And:

    b) Accompany it with a written offer, valid for at least three
    years, to give any third party, for a charge no more than your
    cost of physically performing source distribution, a complete
    machine-readable copy of the corresponding source code, to be
    distributed under the terms of Sections 1 and 2 above on a medium
    customarily used for software interchange; or,

	Which, you'll notice, says you must *accompany* the distribution with a
written offer. There is no way this offer could be enforced by someone who
did not possess it or a copy of it. How would you know who to contact, the
amount to pay, and so on?

	So if you neither possess the binary nor a copy of an offer for the source,
you are not entitled to it. At least, that's how I read this.

	DS


