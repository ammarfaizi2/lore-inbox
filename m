Return-Path: <linux-kernel-owner+w=401wt.eu-S1030320AbWLTT3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWLTT3j (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWLTT3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:29:39 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:1110 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030305AbWLTT3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:29:38 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Marek Wawrzyczny" <marekw1977@yahoo.com.au>, <valdis.kletnietks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Wed, 20 Dec 2006 11:29:00 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEOHAHAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200612200511.kBK5BFo4019459@turing-police.cc.vt.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 20 Dec 2006 12:32:04 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 20 Dec 2006 12:32:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is a can of worms, and then some.  For instance, let's consider this
> Latitude.  *THIS* one has an NVidia Quadro NVS 110M in it.
> However, that's
> not the default graphics card on a Latitude D820.  So what number do you
> put in?  Do you use:

> a) the *default* graphics card
> b) the one *I* have with the open-source driver
> c) the same one, but with the NVidia binary driver?


> Similar issues are involved with the wireless card - the Intel 3945 I
> have isn't the default.  Repeat for several different disk options, and
> at least 4 or 5 different CD/ROM/DVD options.  Add in the fact that Dell
> often changes suppliers for disk and CD/DVD drives, and you have
> a nightmare
> coming...

> And then there's stuff on this machine that are *not* options, but don't
> matter to me.  I see an 'O2 Micro' Firewire in the 'lspci' output.  I have
> no idea how well it works.  I don't care what it contributes to the score.
> On the other hand, somebody who uses external Firewire disk enclosures may
> be *very* concerned about it, but not care in the slightest about
> the wireless
> card.
>
> Bonus points for figuring out what to do with systems that have some chip
> that's a supported XYZ driver, but wired up behind a squirrely bridge with
> some totally bizarre IRQ allocation, so you end up with something that's
> visible on lspci but not actually *usable* in any real sense of
> the term...

Let's not let the perfect be the enemy of the good. Remember, the goal is to
allow consumers to know whether or not their system's hardware
specifications are available. It's not about driver availability -- if the
hardware specifications are available and a driver is not, that's not the
hardware manufacturer's fault.

Linux is about *allowing* people to do things.

DS


