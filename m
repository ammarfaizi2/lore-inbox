Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTEWDBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 23:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTEWDBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 23:01:48 -0400
Received: from mail.webmaster.com ([216.152.64.131]:53682 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263597AbTEWDBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 23:01:48 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <viro@parcelfarce.linux.theplanet.co.uk>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch?] truncate and timestamps
Date: Thu, 22 May 2003 20:14:50 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIELPDCAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "POSIX says" has value only if there is at least some consensus among
> implementations.  Otherwise it's worthless, simply because any program
> that cares about portability can't rely on specified behaviour and
> any program that doesn't couldn't care less anyway - it will rely on
> actual behaviour on system it's supposed to run on.

	This type of attitude ensures there never will be a consensus among
implementations. A lack of consensus today is not grounds for failing to
comply with a standard specifically designed to eliminate that lack.

	On the other hand, that has to be balanced by how objectively reasonable or
unreasonable the standard is. However, there should be an extremely strong
preference for concurring with the standard, even against the weight of
other implementations.

	DS


