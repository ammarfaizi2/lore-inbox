Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030850AbWI0VGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030850AbWI0VGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030852AbWI0VGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:06:00 -0400
Received: from mail1.webmaster.com ([216.152.64.169]:25870 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1030850AbWI0VF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:05:59 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPLv3 Position Statement
Date: Wed, 27 Sep 2006 14:05:13 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEEFOLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060927123247.GA14668@thunk.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 27 Sep 2006 14:08:16 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 27 Sep 2006 14:08:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Many people believe that the GPL infects across
> shared library links.  Whether or not that's true, it's never been
> tested in court, and probably depends on the legal jurisdiction.

It's absurd and has been thoroughly refuted many times. A program can link
with a shared library that was wholly developed *after* that program was
developed. How can a work be a derivative work of a work that was made after
it and fully independently of it?

The GPL only infects derivative works. You cannot create a work that must be
subject to the GPL unless you creatively copy significant protectable
expression from a GPL'd work when you create that work.


For example, I write a program that dynamically links to a 'malloc.so'
library. You then later write your own 'malloc.so' library with some funky
allocator in it and you GPL it. Nobody could ever sanely argue that someone
linking my program with your library changes the licensing requirements of
my program.

The law is really quite clear that one work can only be derivative work of
another if it contains significant protectable expression copied from that
work.

[from another post]
> But OTOH, linking code makes it a combined work.

Linking does not create a work, it only combines existing works. Dynamic
linking is not a creative authoring process and cannot produce a work for
copyright purposes, derivative or otherwise.

There certainly might be cases where two works dynamically link to each
other and one is also a derivative work of the other. But such a general
rule totally defies common sense. The law is clear that a derivative work is
made when you creatively take significant protected expression from another
work, beyond what is needed for interoperability.

Linking may make a work in an informal sense, but it does not create a work
for copyright purposes. Only creative expression makes a work. Linkers do
not express themselves creatively, artfully picking and choosing one among
dozens of equally-valid options.

DS


