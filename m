Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424927AbWLCE3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424927AbWLCE3d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 23:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424928AbWLCE3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 23:29:33 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:63245 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1424927AbWLCE3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 23:29:32 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Cc: <schwab@suse.de>
Subject: RE: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Sat, 2 Dec 2006 20:29:28 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEMLABAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <E9F17630-A879-4EEC-8ACB-5E339DB0C79F@mac.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 02 Dec 2006 21:32:41 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 02 Dec 2006 21:32:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > It comes down to just what those guarantees GCC provides actually are.

> This is the first correct statement in your email.  In any case the
> documented GCC guarantees have always been much stronger than you
> have been trying to persuade us they should be.  I would argue that
> the C standard somewhat indirectly specifies those guarantees but I
> really don't have the heart for any more language-lawyering so I'm
> going to leave it at that.

I have tried to find any documentation of the guarantees gcc actually
provides and have been unable to do so. Where are these "documented GCC
guarantees" documented?

DS


