Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264646AbUFPXpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbUFPXpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 19:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUFPXpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 19:45:39 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:58898 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S264646AbUFPXpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 19:45:36 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <oliver@neukum.org>
Cc: <erikharrison@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: RE: more files with licenses that aren't GPL-compatible
Date: Wed, 16 Jun 2004 16:45:28 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIELGMKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200406170045.32844.oliver@neukum.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 16 Jun 2004 16:23:16 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 16 Jun 2004 16:23:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Am Mittwoch, 16. Juni 2004 23:21 schrieb David Schwartz:

> >     b) You must cause any work that you distribute or publish, that in
> >     whole or in part contains or is derived from the Program or any
> >     part thereof, to be licensed as a whole at no charge to all third
> >     parties under the terms of this License.
> >

> >         How can you cause the Linux kernel combined with this
> > firmware to be
> > licensed under the terms of the GPL? (And, by the way, I think this
> > prohibits trademark as well, which is very interesting.)

> This all boils down to the question of whether fimware is code or not.

	Perhaps I'm missing something. Can you explain why you think that matters?
I'll repeat the GPL section I'm talking about:

     b) You must cause any work that you distribute or publish, that in
     whole or in part contains or is derived from the Program or any
     part thereof, to be licensed as a whole at no charge to all third
     parties under the terms of this License.

	First, this says, "any work", it's not limited to code. It says, "in whole
or in part contains or is derived from the Program" -- a binary of the Linux
kernel is clearly derived from the Linux kernel source. And it says
"licensed *as a whole* ... under the terms of *this* license".

	So where's the gray area you seem to be imagining?

> As this question is extremely unlikely to be resolved on this list and
> was discussed here several times already, I kindly request that
> you take this discussion to a legalistic list and confine traffic of this
> kind on this list to clear and technical issues.

	This is a different issue. This isn't about distributing firmware and
whether the firmware itself is a derived work. This is about distributing
the Linux kernel as a work containing non-GPL'd elements with use
restrictions. GPL section 2b authoritatively prohibits this. There is no
gray area here.

	This is a clear issue, but not a technical one. However, being unable to
distribute binaries of the Linux kernel would present numerous technical
problems.

	DS


