Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbTLHCdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbTLHCdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:33:00 -0500
Received: from mail.webmaster.com ([216.152.64.131]:30660 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265305AbTLHCc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:32:59 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Additional clauses to GPL in network drivers
Date: Sun, 7 Dec 2003 18:32:54 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKELHIIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <200312071515.hB7FFkQH000866@81-2-122-30.bradfords.org.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	It occurs to me that it might not be a bad idea to have a short blurb that
could be included in individual files that clarifies that the file is part
of a GPL'd distribution but that's clear that it doesn't impose any
additional restrictions. Here's a stab at such a notice just off the top of
my head:

The contents of this is file are protected by copyright and consist of
portions of the Linux kernel source code. The Linux kernel source code is
distributed and licensed under the terms of the GPL and no permission is
granted to distribute this file, or works derived therefrom, under any other
terms. The full terms of the GPL should have been included with your
distribution in a file called 'COPYING'.

	Note that if you want to use this file (or portions of it) in another
project that's also distributed under the GPL, it's perfectly reasonable to
remove or modify this paragraph. We could also have a version that would
survive even that change, maybe like this:

The contents of this is file are protected by copyright and were distributed
to you as a portion of a work distributed under the terms of the GPL and all
other rights are reserved by the respective authors. No permission is
granted to distribute this file, or works derived therefrom, under any other
terms. The full terms of the GPL should have been included with your
distribution in a file called 'COPYING'.

	DS


