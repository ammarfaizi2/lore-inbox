Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUFPVW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUFPVW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266299AbUFPVW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:22:59 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:19720 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S264815AbUFPVW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:22:56 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <erikharrison@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: more files with licenses that aren't GPL-compatible
Date: Wed, 16 Jun 2004 14:21:56 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEKKMKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <5b18a542040616133415bf54d1@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 16 Jun 2004 13:59:43 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 16 Jun 2004 13:59:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 15 Jun 2004 21:11:00 -0700, David Schwartz
> <davids@webmaster.com> wrote:

> > They can't grant that permission. Every single person
> > who had contributed
> > to the Linux kernel would have to agree. The GPL prohibits including
> > software that isn't itself GPL'd from being combined with GPL'd
> > software.
> > The issue is not permission to distribute this driver, the issue is
> > permission to distribute the *kernel*. The kernel's license prohibits
> > distrubiting it in combination with works that have licenses more
> > restrictive than the GPL.
>
> That better be bogus, or else vendors are going to be very upset that
> they can't ship the kernel with, say, trademarked images. For example,
> Mozilla's trademark on their artwork is fairly restrictive, or the
> Mandrake Firewall product (if that's even still around - I don't keep
> up).

	I can't speak to the trademark issue. I don't know enough about how the GPL
deals with possible trademark issues. I believe you could not embed
trademarked images into the kernel and distribute the result either.

	However, this is a pure copyright issue. You cannot combine GPL'd code with
code that has a more restrictive license and distribute the resulting
binaries. Read GPL section 2b:

  2. You may modify your copy or copies of the Program or any portion
of it, thus forming a work based on the Program, and copy and
distribute such modifications or work under the terms of Section 1
above, provided that you also meet *all* of these conditions:

...

    b) You must cause any work that you distribute or publish, that in
    whole or in part contains or is derived from the Program or any
    part thereof, to be licensed as a whole at no charge to all third
    parties under the terms of this License.

	How can you cause the Linux kernel combined with this firmware to be
licensed under the terms of the GPL? (And, by the way, I think this
prohibits trademark as well, which is very interesting.)

	DS


